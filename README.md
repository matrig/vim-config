My vim configuration
====================

This folder has my vim configuration. I don't have any kind of write-up where I explain it, but fortunately the internet abounds with good vim resources.
Clone with:

    git clone --recursive git://github.com/matrig/vim-config.git ~/.vim

(`--recursive` is necessary in order to clone the submodules containing the external packages).

Adding a new submodule
----------------------

To add another package hosted on github as a submodule:

    git submodule add git://github.com/path_to/submodule.git ./bundle/submodule_name

followed by:

    git submodule foreach git submodule init && git submodule foreach git submodule update
    
Updating all submodules after upstream change
---------------------------------------------

    git submodule foreach git pull origin master

Then commit to github:

    git commit -am "Pulled down update to submodules"

Updating all submodules locally
-------------------------------

First do:

    git pull
    
Then to update all the submodules:

    git submodule update --init --recursive
    
Removing a submodule
--------------------

    git submodule deinit submodule_name
    git rm submodule_name
