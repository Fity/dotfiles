function delete_squashed_branches --description 'delete merged branches(merged after a squash)'
    # do mergeBase=$() && [[]] && git branch -D $branch; done
    set branches ()
    for branch in (git checkout -q master; and git for-each-ref refs/heads/ "--format=%(refname:short)")
        set -l mergeBase (git merge-base master $branch)
        [ $mergeBase ]; and string match -r '^-.*' -- (git cherry master (git commit-tree (git rev-parse $branch^\{tree\}) -p (git merge-base master $branch) -m _)); and git branch -D $branch
    end
end
