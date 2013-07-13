My vim configuration
====================

This folder has my vim configuration. I don't have any kind of write-up where I explain it, but fortunately the internet abounds with good vim resources.
Clone with:

    git clone --recursive https://github.com/matrig/vim-config.git

(`--recursive` is necessary in order to clone the submodules containing the external packages).

Adding a new submodule
----------------------

To add another package hosted on github as a submodule:

    git submodule add git://github.com/path_to/submodule.git ./bundle/submodule_name    
    git submodule init && git submodule update
    git submodule foreach git submodule init && git submodule foreach git submodule update
    
Updating all submodules
-----------------------

To update all the submodules:

    git submodule foreach git pull origin master
    
or

    git submodule update --recursive
