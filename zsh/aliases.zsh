alias reload!='. ~/.zshrc'
alias 1803='class 1803'
alias 6006='class 6006'

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
