# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# so you don't have to use ./ to run something in the same directory:
PATH=$PATH:.
export PATH
# see http://www.reddit.com/r/linux/comments/2k1qz5/post_something_that_makes_your_linux_life_easier/clhi4tj
# and http://www.troubleshooters.com/linux/prepostpath.htm
# for more information

# via https://help.dreamhost.com/hc/en-us/articles/360001435926-Installing-OpenSSL-locally-under-your-username
# due to pip error mentioned at https://help.dreamhost.com/hc/en-us/articles/115000702772-Installing-a-custom-version-of-Python-3
export PATH=$HOME/openssl/bin:$PATH
export LD_LIBRARY_PATH=$HOME/openssl/lib
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/home/paul/openssl/lib -Wl,-rpath,/home/paul/openssl/lib"

