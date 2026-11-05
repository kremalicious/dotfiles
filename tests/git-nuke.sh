#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../bin" && pwd)
test_root=$(mktemp -d)
test_root=$(cd "$test_root" && pwd -P)
trap 'printf "Test files: %s\n" "$test_root"' EXIT
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export NUKE_TEST_SCRIPT="$script_dir/git-nuke.sh"

run_nuke() {
  git -c "alias.nuke=!bash \"\$NUKE_TEST_SCRIPT\"" nuke
}

create_repository() {
  mkdir "$test_root/$1"
  cd "$test_root/$1"
  git init --quiet --initial-branch=main
  git config user.name Test
  git config user.email test@example.invalid
  git config commit.gpgSign false
  printf 'initial\n' > tracked
  git add tracked
  git commit --quiet -m Initial
}

create_repository cancellation
git switch --quiet -c feature
git worktree add --quiet "$test_root/cancel-worktree" -b linked
before=$(git worktree list --porcelain)
for answer in no '' nuke-extra; do
  printf '%s\n' "$answer" | run_nuke > "$test_root/output"
  [ "$(git worktree list --porcelain)" = "$before" ]
  [ "$(git branch --show-current)" = feature ]
  [ "$(git for-each-ref --format='%(refname)' refs/heads/)" = $'refs/heads/feature\nrefs/heads/linked\nrefs/heads/main' ]
done
run_nuke < /dev/null > "$test_root/output"
[ "$(git worktree list --porcelain)" = "$before" ]
printf 'PASS: rejection and EOF leave branches and worktrees unchanged\n'

create_repository removal
git switch --quiet -c feature
printf 'unmerged\n' > tracked
git commit --quiet -am Unmerged
git update-ref refs/remotes/origin/feature HEAD
remote_commit=$(git rev-parse refs/remotes/origin/feature)
printf 'preserve\n' > local-file
linked_path="$test_root/linked space"
git worktree add --quiet "$linked_path" main
(
  cd "$linked_path"
  printf 'dirty\n' > tracked
  printf 'untracked\n' > untracked
  printf 'ignored\n' > .gitignore
  printf 'ignored\n' > ignored
)
git worktree lock "$linked_path"
detached_path="$test_root/"$'detached\nworktree'
git worktree add --quiet --detach "$detached_path"
(
  cd "$linked_path"
  printf 'nuke\n' | run_nuke > "$test_root/output"
)
[ "$(git branch --show-current)" = main ]
[ "$(git for-each-ref --format='%(refname)' refs/heads/)" = refs/heads/main ]
[ "$(git rev-parse refs/remotes/origin/feature)" = "$remote_commit" ]
[ "$(cat tracked)" = initial ]
[ "$(cat local-file)" = preserve ]
[ ! -e "$linked_path" ]
[ ! -e "$detached_path" ]
[ "$(git worktree list --porcelain)" = "$(printf 'worktree %s\nHEAD %s\nbranch refs/heads/main' "$PWD" "$(git rev-parse HEAD)")" ]
printf -v expected 'Run: cd %q' "$PWD"
grep -Fx "$expected" "$test_root/output" > /dev/null
printf 'PASS: confirmation removes dirty, locked, and detached worktrees and unmerged branches\n'

printf 'local change\n' > tracked
printf 'nuke\n' | run_nuke > "$test_root/output"
[ "$(cat tracked)" = 'local change' ]
[ "$(git branch --show-current)" = main ]
printf 'PASS: main with no other branches retains local changes\n'

create_repository conflict
git switch --quiet -c feature
printf 'feature\n' > tracked
git commit --quiet -am Feature
printf 'local change\n' > tracked
git worktree add --quiet "$test_root/conflict-worktree" -b linked
before=$(git worktree list --porcelain)
if printf 'nuke\n' | run_nuke > "$test_root/output" 2>&1; then
  printf 'FAIL: conflicting primary changes were accepted\n' >&2
  exit 1
fi
grep -F 'Your local changes to the following files would be overwritten by checkout:' "$test_root/output" > /dev/null
[ "$(git worktree list --porcelain)" = "$before" ]
[ "$(cat tracked)" = 'local change' ]
[ "$(git for-each-ref --format='%(refname)' refs/heads/)" = $'refs/heads/feature\nrefs/heads/linked\nrefs/heads/main' ]
printf 'PASS: a conflicting switch stops before deletion\n'

git branch -m main missing-main
before=$(git worktree list --porcelain)
if printf 'nuke\n' | run_nuke > "$test_root/output" 2>&1; then
  printf 'FAIL: missing main was accepted\n' >&2
  exit 1
fi
[ "$(cat "$test_root/output")" = 'No local main branch. Create it before running git nuke.' ]
[ "$(git worktree list --porcelain)" = "$before" ]
printf 'PASS: missing main stops before changes\n'
