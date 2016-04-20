#!/usr/bin/env fish

#####################################################
# Bootup script for my fish shell
# @Author: Fity(imfity@gmail.com)
# @Website: http://fity.me
# @Gihub: https://github.com/fity
#####################################################
echo "Bootup my fish env, install fish-shell with `brew install fish` first"

function brew_install_dep
    set soft_name $argv[1]
    if test (count $argv) -gt 1
        set purpose 'for' $argv[2]
    end
    echo "brew install $soft_name $purpose"
    # brew install $soft_name
end

function pip_install_dep
    set soft_name $argv[1]
    if test (count $argv) -gt 1
        set purpose "for" $argv[2]
    end
    echo "pip install $soft_name $purpose"
    sudo pip install $soft_name
end

# install dependences
pip_install_dep "percol" "history select search"
pip_install_dep virtualenv
pip_install_dep virtualfish

brew_install_dep the_silver_searcher

echo "remove exists config"
rm -rf ~/.config/fish
echo "link to system config"
ln -s $PWD ~/.config/fish
