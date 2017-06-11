#!/usr/bin/env bash
# 
# Usage:
# ./updaterepos.sh [parent_directory] 
#
#   example usage:
#   ./updaterepos.sh projects/ [MAKE SURE YOU USE / SLASHES]
#
# stolen from:
# http://stackoverflow.com/a/36800741/733677
#

updateRepo() {
    local dir="$1"
    local original_dir="$2"
    cd "$dir" || return # switch to the git repo
    repo_url=$(git config --get remote.origin.url)
    
    echo "$(tput setaf 136)Updating Repo: $dir with url: $repo_url$(tput sgr0)"
    
    main_branch="master"
    if [ "$repo_url" == "git@someserver:repo/repo.git" ]; then # if you have a repo where the primary branch isnt master
        main_branch="trunk"
    fi

    # update the repo, then stash any local changes
    echo "$(tput setaf 240)calling: git fetch --all && git stash$(tput sgr0)"
    (git fetch --all && git stash)
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # switch to master/trunk branch and rebase it, then switch back to original branch
    if [ "$current_branch" != $main_branch ]; then
        echo "$(tput setaf 240)calling: git checkout $main_branch && git rebase && git checkout $current_branch $(tput sgr0)"
        (git checkout $main_branch && git rebase && git checkout "$current_branch")
    fi

    # rebase the original branch and then stash pop back to original state
    echo "$(tput setaf 240)calling: git rebase && git stash pop on branch: $current_branch $(tput sgr0)"
    (git rebase && git stash pop ) 

    # switch back to the starting directory
    cd "$original_dir" || return
    echo ""
}

directory_to_update=${1}

if [ -z "$directory_to_update" ] ; then
    echo "$(tput setaf 240)no directory passed in, using current directory$(tput sgr0)"
    directory_to_update=$PWD
fi 

echo "$(tput setaf 240)Updating git repos in directory: $directory_to_update $(tput sgr0)"

count=0

for dir in $(find "$directory_to_update" -maxdepth 4 -type d -name .git | xargs -n 1 dirname); do
    updateRepo "$dir" "$directory_to_update"
    ((count+=1))
done

echo "$(tput setaf 76)✓ $count local git repos have been updated!$(tput sgr0)"
