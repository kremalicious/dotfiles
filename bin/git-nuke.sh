#!/usr/bin/env bash

# Keep the primary checkout on main and remove all other local branches and linked worktrees.
#
# Preview removals and require typing nuke to confirm.
#
# Removal includes unmerged branches, locked worktrees, and their uncommitted, untracked, and ignored files.
#
# Require a local main branch. Stop if primary checkout changes prevent the switch.
# Preserve primary checkout changes and remote branches.
#
# If the invoking worktree is removed, print a cd command for the surviving checkout.

set -euo pipefail

if [ "$#" -ne 0 ]; then
  printf 'Usage: git nuke\n' >&2
  exit 1
fi

if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != true ]; then
  printf 'Run git nuke inside a working tree.\n' >&2
  exit 1
fi

if ! git show-ref --verify --quiet refs/heads/main; then
  printf 'No local main branch. Create it before running git nuke.\n' >&2
  exit 1
fi

invocation_root=$(git rev-parse --show-toplevel)
worktree_state=$(git worktree list --porcelain)
worktrees=()
while IFS= read -r -d '' field; do
  case "$field" in
    'worktree '*) worktrees+=("${field#worktree }") ;;
    bare)
      printf 'The primary repository is bare. Run git nuke in a non-bare repository.\n' >&2
      exit 1
      ;;
  esac
done < <(git worktree list --porcelain -z)

primary_root=${worktrees[0]}
cd "$primary_root"
# Git shell aliases export the invoking worktree's repository context.
unset GIT_DIR GIT_WORK_TREE GIT_COMMON_DIR GIT_INDEX_FILE GIT_PREFIX GIT_IMPLICIT_WORK_TREE

branch_list=$(git for-each-ref --format='%(refname)' refs/heads/)
branches=()
while IFS= read -r ref; do
  if [ "$ref" != refs/heads/main ]; then
    branches+=("${ref#refs/heads/}")
  fi
done <<< "$branch_list"

printf 'Keep checkout: %q (on main)\n' "$primary_root"
printf 'Remove linked worktrees (%d):\n' "$((${#worktrees[@]} - 1))"
for ((i = 1; i < ${#worktrees[@]}; i++)); do
  printf '  %q\n' "${worktrees[i]}"
done
printf 'Delete local branches (%d):\n' "${#branches[@]}"
for ((i = 0; i < ${#branches[@]}; i++)); do
  printf '  %q\n' "${branches[i]}"
done
printf '\nLinked worktrees will be removed even if dirty or locked.\n'
printf 'Their uncommitted, untracked, and ignored files will be lost.\n'
printf 'Unmerged local branches will be deleted. Remote branches are unchanged.\n'
printf 'Type nuke to confirm: '
if ! IFS= read -r confirmation || [ "$confirmation" != nuke ]; then
  printf 'Cancelled.\n'
  exit 0
fi

if [ "$(git worktree list --porcelain)" != "$worktree_state" ] ||
  [ "$(git for-each-ref --format='%(refname)' refs/heads/)" != "$branch_list" ]; then
  printf 'Branches or worktrees changed. Run git nuke again to review the new plan.\n' >&2
  exit 1
fi

printf 'Switching primary checkout to main\n'
git switch --quiet --no-overwrite-ignore --ignore-other-worktrees main

for ((i = 1; i < ${#worktrees[@]}; i++)); do
  printf 'Removing worktree %q\n' "${worktrees[i]}"
  git worktree remove --force --force -- "${worktrees[i]}"
done

for ((i = 0; i < ${#branches[@]}; i++)); do
  printf 'Deleting branch %q\n' "${branches[i]}"
  git branch --delete --force -- "${branches[i]}" >/dev/null
done

printf 'Done. Only main remains.\n'
if [ "$invocation_root" != "$primary_root" ]; then
  printf 'Run: cd %q\n' "$primary_root"
fi
