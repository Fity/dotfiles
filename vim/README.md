$MYVIMRC
========
Using vundle as plugin manager.  
Plugin used as shown in the vimrc file.

Usage
=====
Set up your [vundle](https://github.com/gmarik/Vundle.vim).  
Copy the vimrc to local.  
Plugin install in vim, using vindle.  
Maybe the YCM plugin need more configuration.  

### For YCM
```
cd ~/.vim/bundle/YouCompleteMe/
./install.sh --clang-completer
```

### For pep8 checker
Make sure that pep8(command line tool) can be found in your $PATH
Or, install it as below:
`sudo pip install pep8`
