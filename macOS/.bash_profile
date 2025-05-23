# eliminates warning on Catalina re: switching to zsh
# via https://www.addictivetips.com/mac-os/hide-default-interactive-shell-is-now-zsh-in-terminal-on-macos/
export BASH_SILENCE_DEPRECATION_WARNING=1

# added by Anaconda3 2019.10 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/opt/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# git/GitHub aliases:
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gf='git fetch'
alias gfo='git fetch origin'
# since gp is already `git pull`, use gg (think "git get"!)
alias gg='git pull'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin main'
alias gs='git status -sb'

CYAN='\e[0;36m\]'
GRAY='\[\033[0m\]'
GREEN='\[\033[0;32m\]'
PURPLE='\[\033[0;35m\]'
RED='\e[0;31m\]'

# https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt

function RGBcolor {                                               
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc                        
}

ORANGE=$(RGBcolor 5 3 0)  # Bright orange.

PS1="${GREEN}\u ${GRAY}\w ${RED}λ ${GRAY}"

