# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# see also the "/etc/issue" and "/etc/motd" files
#     http://www.linuxquestions.org/questions/linux-newbie-8/how-to-setup-system-login-banner-and-login-message-298266/

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

# default PS1:
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# more default PS1 stuff:
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias lal='ls -alh'
alias lll='ls -alh'
#alias l='ls -CF'
alias l='ls -lh'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set editor
export EDITOR=/usr/bin/vim

CYAN='\e[0;36m'
GRAY='\[\033[0m\]'
GREEN='\[\033[0;32m\]'
PURPLE='\[\033[0;35m\]'
RED='\e[0;31m'

# uptime && users
#fortune | cowsay -f dalek
#echo -e "$RED"
curl -s https://en.wikiquote.org/wiki/Template:QoD | grep -A 7 \<p\> | sed 's/<[^>]\+>//g' | cowsay -f dalek
echo -e "$CYAN"

echo
ddate
echo

# http://www.garron.me/en/go2linux/what-is-my-public-ip-command-line.html
GetMyIP() {
    curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//';
}

# see if a number is prime:
#  http://montreal.pm.org/tech/neil_kandalgaonkar.shtml
IsNumberPrime() {
    #echo Testing...
    perl -wle 'print "Prime" if (1 x shift) !~ /^1?$|^(11+?)\1+$/' $1
}

# Determine length of string
#  There are several ways to do this:
#   http://www.folkstalk.com/2012/09/find-length-of-string-in-unix-linux.html
Length() {
    echo "$1" | awk '{print length}'
}

# http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/
mkdircd() {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

# Get quote-of-the-day from Wikiquote:
QuoteOfTheDay() {
    if [ -z "$1" ]
    then
        curl -s https://en.wikiquote.org/wiki/Template:QoD | grep -A 7 \<p\> | sed 's/<[^>]\+>//g' | cowsay -f kilroy
    else
        curl -s https://en.wikiquote.org/wiki/Template:QoD | grep -A "$1" \<p\> | sed 's/<[^>]\+>//g' | cowsay -f kilroy
    fi
}

# taken from http://www.pixelbeat.org/settings/.bashrc
ord() { printf "0x%x\n" "'$1"; }
chr() { printf $(printf '\\%03o\\n' "$1"); }

# from http://www.cyberciti.biz/tips/linux-unix-pause-command.html
function pause() {
   read -p "$*"
}

bashForkBomb=":(){ :|:& };:";

alias ..='cd ..'
alias bomb='echo ${bashForkBomb}'
alias c='clear'
alias check-log='cat /var/log/auth.log | grep fail'
alias cp='cp -r'
alias df='df -h'
alias diff='colordiff'
alias disapprove='echo ಠ_ಠ'
alias du='du -d 1 -h'
alias floppy='sudo mount -t vfat -o uid=paul,gid=pi /dev/sda /media/floppy-disk/'
alias forkbomb='echo ${bashForkBomb}'
alias get='sudo apt-get install'
alias gh='history | grep'
alias google='w3m google.com'
alias h='history'
alias html='sudo python /home/paul/Programming/python/makeHTML.py'
# IRC client was 'irssi', 'weechat-curses'
alias irc='weechat'
alias konami='echo up, up, down, down, left, right, left, right, B, A, Start'
alias len='Length'
alias length='Length'
# list only directories in the current folder
# from http://www.reddit.com/r/linux4noobs/comments/2hqdq1/i_uploaded_some_scripts_that_just_make_a_gnulinux/ckw0jli
alias lsd='ls -ld */'
alias matlab='sudo octave'
alias mcd='mkdircd'
alias myip='curl http://ifconfig.me/ip'
alias myip2='GetMyIP'
alias myip3='curl https://shtuff.it/myip/short/'
alias myip4='curl icanhazip.com'
alias nano='vi'
alias nethack='telnet nethack.alt.org'
# via http://stackoverflow.com/questions/3001177/how-do-i-grep-for-all-non-ascii-characters-in-unix
alias non-ascii='grep --color='auto' -P -n "[\x80-\xFF]"'
alias noop=':'
alias nop=':'
alias nyan='telnet -e ^c nyancat.dakko.us'
alias nyay='echo Ññ'
alias octave='sudo octave'
# or openports: netstat -tuln
alias pico='vi'
alias ports='netstat -tulanp'
alias prime='IsNumberPrime'
alias q='exit'
alias qod='QuoteOfTheDay'
alias quit='exit'
alias quote='QuoteOfTheDay'
alias r='sudo R'
alias R='sudo R'
alias reboot='sudo reboot'
# alternative: reload = '. ~/.bashrc'
alias reload='. /home/paul/.bashrc'
alias remove='sudo apt-get --purge remove'
alias rfk='robotfindskitten'
alias root='sudo -i'
# attempting sudo !! aliased: sudo !! or sudo !-1 have not worked...
alias s='sudo "$BASH" -c "$(history -p !!)"'
alias sl='sl -ael'
# see http://scribblebound.com/2014-02-22.html
alias snake='telnet telnet.bitlag.net'
alias sprunge='curl -F '"'"'sprunge=<-'"'"' http://sprunge.us'
alias su='sudo -i'
alias u='uptime && users'
alias unmount='umount'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias usb='sudo mount -t vfat -o uid=paul,gid=pi /dev/sda /media/usbstick/'
alias usb1='sudo mount -t vfat -o uid=paul,gid=pi /dev/sda1 /media/usbstick/'
alias usb2='sudo mount -t vfat -o uid=paul,gid=pi /dev/sda2 /media/usbstick/'
alias website='pushd /var/www'
alias why='python /home/paul/Programming/python/why/why.py'
alias why?='python /home/paul/Programming/python/why/why.py'
alias words='cat /usr/share/dict/american-english-insane'
alias x='exit'
alias xyzzy='echo Cheater.'
alias y='yes'
alias zzz='echo $1'

# Change bash prompt:
#    things you can do: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
#    colors: http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# was >> (like MATLAB) until I changed PuTTY's settings to be able to use λ
# other characters: →
PS1="${GREEN}\u ${GRAY}\w ${PURPLE}λ ${GRAY}"

# make man use color:
export PAGER=most
# "Formats man page contents to be 80 chars wide or less (because they are much easier to read that way)."
export MANWIDTH=80
# both of the above are from http://www.reddit.com/r/linux/comments/2k1qz5/post_something_that_makes_your_linux_life_easier/

# changed di from 01;34 to 00;36 (directories; bold blue to regular cyan)
# changed ex to non-bold blue (executable files)
# changed so no bolds
#
#    colors:
# txtblk='\e[0;30m' # Black - Regular
# txtred='\e[0;31m' # Red
# txtgrn='\e[0;32m' # Green
# txtylw='\e[0;33m' # Yellow
# txtblu='\e[0;34m' # Blue
# txtpur='\e[0;35m' # Purple
# txtcyn='\e[0;36m' # Cyan
# txtwht='\e[0;37m' # White
# bldblk='\e[1;30m' # Black - Bold
# bldred='\e[1;31m' # Red
# bldgrn='\e[1;32m' # Green
# bldylw='\e[1;33m' # Yellow
# bldblu='\e[1;34m' # Blue
# bldpur='\e[1;35m' # Purple
# bldcyn='\e[1;36m' # Cyan
# bldwht='\e[1;37m' # White
# unkblk='\e[4;30m' # Black - Underline
# undred='\e[4;31m' # Red
# undgrn='\e[4;32m' # Green
# undylw='\e[4;33m' # Yellow
# undblu='\e[4;34m' # Blue
# undpur='\e[4;35m' # Purple
# undcyn='\e[4;36m' # Cyan
# undwht='\e[4;37m' # White
# bakblk='\e[40m'   # Black - Background
# bakred='\e[41m'   # Red
# bakgrn='\e[42m'   # Green
# bakylw='\e[43m'   # Yellow
# bakblu='\e[44m'   # Blue
# bakpur='\e[45m'   # Purple
# bakcyn='\e[46m'   # Cyan
# bakwht='\e[47m'   # White
# txtrst='\e[0m'    # Text Reset
#
# from https://wiki.archlinux.org/index.php/Color_Bash_Prompt

LS_COLORS="rs=0:di=00;36:ln=00;36:mh=00:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.tlz=00;31:*.txz=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.lz=00;31:*.xz=00;31:*.bz2=00;31:*.bz=00;31:*.tbz=00;31:*.tbz2=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.war=00;31:*.ear=00;31:*.sar=00;31:*.rar=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.webm=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.axv=00;35:*.anx=00;35:*.ogv=00;35:*.ogx=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:*.pdf=00;91:"

. /home/paul/.bashrc_secret

