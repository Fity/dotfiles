function gpl --description 'alias for git pull'
	set current_branch (git branch | sed -n '/\* /s///p')
    git pull origin $current_branch
end
