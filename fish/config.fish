set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
set -x LC_TYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x FISH_PATH $HOME/.config/fish

set -x EDITOR vim

# used by ls, change the color
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# local bin (located at $HOME/bin)
set -gx PATH $PATH $HOME/bin

# source the autojump script
source /usr/local/etc/autojump.fish

# go related settings
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/repos/go
set -x PATH $PATH $GOPATH/bin


# python virtualenv wrapper(virtualfish settings
# . $HOME/.config/virtualfish/virtual.fish
# related plugins
# . $HOME/.config/virtualfish/projects.fish
eval (python -m virtualfish compat_aliases)

function fish_user_key_bindings
  bind \cr percol_select_history
end

# autoload boot2docker vars
if boot2docker status | grep 'running'
    for opt in (boot2docker shellinit)
        eval $opt
    end
    set -x TSUBAKI '/Users/yangdf/repos/tsubaki'
end

# autoenv support
source ~/.config/fish/autoenv.fish

# tmux support
alias pg.start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg.stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias vim='env PYTHONPATH=./ vim'
alias mvim='env PYTHONPATH=./ mvim'
alias e='env PYTHONPATH=./ vim'
