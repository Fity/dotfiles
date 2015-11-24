#!/usr/bin/env fish
######################################################################
function backup_old_conf
    if test -d .vim
        echo 'backup old .vim folder'
        mv .vim vim.bak
    else
        echo 'make a new folder named .vim.bak'
        mkdir .vim.bak
    end
    if test -f .vimrc
        echo 'put your old .vimrc file into .vim.bak folder'
        mv .vimrc vim.bak
    end
end
######################################################################
function init_conf_env
  cd
  mkdir .vim
  # copy .ycm_extra_conf.py files
  # .vim/.ycm_extra_conf.py
  mkdir -p sessions
  touch .vimrc
end
######################################################################
echo 'Init vim env, Mac only now.'
echo 'old .vim folder will be renamed to vim.bak and the old .vimrc will be put there.'
cd
backup_old_conf
init_conf_env
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
echo 'finished'
