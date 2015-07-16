# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases

# Utilities
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias gca='git commit -a'
alias gb='git branch'
alias ga='git add'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gco='git checkout'
alias gcp='git cherry-pick'

# Pull
alias gl='git pull --prune'
alias glr='git pull --rebase --prune'
alias glo='gl origin'
alias glro='glr origin'
alias gloc='glo `gcb`'
alias glroc='glro `gcb`'

alias gll='glroc' # Just because it's used 90% of the time

# Push
alias gp='git push'
alias gpo='gp origin'
alias gpoc='gpo `gcb`'

alias gpp='gpoc' # Just because it's used 90% of the time

# Miscellaneous (or I don't really know what these do)
alias gph='git push heroku master'
alias grm="git status | grep deleted | awk '{\$1=\$2=\"\"; print \$0}' | \
           perl -pe 's/^[ \t]*//' | sed 's/ /\\\\ /g' | xargs git rm"
alias glrom='git pull --rebase --prune origin master'

alias hpr='gp && hub pull-request -i'

# Legit alias
alias gbs='legit branches'
alias gsw='legit switch'
alias gpub='legit publish'
alias gunpub='legit unpublish'
alias gsync='legit sync'
alias gn='gsync'
alias gbo='legit sprout'
alias gpc='gpub `gcb`'

function gswp() {
  gsw $1
  git stash pop
}

# Branch-related
alias gcb='git rev-parse --abbrev-ref HEAD' # current branch

