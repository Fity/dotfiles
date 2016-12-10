#this script can never fail
#Usage: put this line into your config.fish
#    source $HOME/.config/fish/ssh_agent_start.fish && start_agent

setenv SSH_ENV $HOME/.ssh/environment


function __setup_env
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
end


function __new_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    __setup_env
end


function start_agent
	if [ -n "$SSH_AGENT_PID" ]
        ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
        if [ $status -eq 0 ]
            __test_identities
        else
            __new_agent
            __load_pri_keys
        end
	else
        __setup_env
        ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
        if [ $status -eq 0 ]
            __test_identities
        else
            __new_agent
            __load_pri_keys
        end
    end
end


function __test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        __load_pri_keys
        if [ $status -eq 2 ]
            start_agent
            __load_pri_keys
        end
    end
    return 0
end


function __load_pri_keys
    for key in $HOME/.ssh/*.pub
        ssh-add -K $HOME/.ssh/(basename $key .pub)
    end
end
