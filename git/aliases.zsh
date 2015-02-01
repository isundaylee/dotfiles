# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glr='git pull --rebase --prune'
alias glrom='git pull --rebase --prune origin master'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{\$1=\$2=\"\"; print \$0}' | \
           perl -pe 's/^[ \t]*//' | sed 's/ /\\\\ /g' | xargs git rm"
alias gph='git push heroku master'
alias ga='git add'
alias glo='glr origin master'
alias glop='glo && gp'

# Legit alias
alias gbs='legit branches'
alias gsw='legit switch'
alias gpub='legit publish'
alias gunpub='legit unpublish'
alias gsync='legit sync'
alias gbo='legit sprout'
alias gpc='gpub `gcb`'

# Branch-related
alias gcb='git rev-parse --abbrev-ref HEAD' # current branch