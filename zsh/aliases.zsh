alias reload!='. ~/.zshrc'
alias re='reload!'
alias 1803='class 1803'
alias 6006='class 6006'

function take() {
  mkdir $1
  cd $1
}

function search() {
    DIR=.

    if [ ! -z $2 ]; then
        DIR=$2
    fi

    grep -r $1 $DIR
}

function class() {
  cd "`find_class $1`"
}

alias dok='ssh dokku@apps '

function puse() {
  lsof -i tcp:$1 $2
}