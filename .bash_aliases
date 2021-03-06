
#########################
# Git
#########################
# Show present working directory and Git branch at prompt
# source: http://www.developerzen.com/2011/01/10/show-the-current-git-branch-in-your-command-prompt/
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# aliases
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gcol="git checkout live"
alias gcom="git checkout master"
alias gcos="git checkout stable"
alias gd="git diff"
alias gl="git lg"
alias gm="git merge"
alias gp="git pull --ff"
alias gpol="git push origin live"
alias gpom="git push origin master"
alias gpos="git push origin stable"
alias gs="git status"

# ANSI colors: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
PURPLE="\[\033[0;35m\]"
LIGHT_GREY="\[\033[0;37m\]"
DARK_GREY="\[\033[1;30m\]"
NO_COLOUR="\[\033[0m\]"

# prompt config:
PS1="\[\033[0;31m\]VAGRANT $LIGHT_GREY\w$PURPLE\$(parse_git_branch)$NO_COLOUR\$ "

#########################
# Drush commands
#########################
alias d="drush"
alias dca="drush cc all"
alias dcssagg-on="vset preprocess_css 1 --yes"
alias dcssagg-off="vset preprocess_css 0 --yes"

#########################
# Misc
#########################
alias ls="ls -la"

#########################
# CD BACKSLASH SHORTHAND
#########################
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# Python
alias python="python3"
alias pip="pip3"
