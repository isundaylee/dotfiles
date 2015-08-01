alias reload!='. ~/.zshrc'
alias re='reload!'
alias 1803='class 1803'
alias 6006='class 6006'

alias ..="cd .."

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

# short url functions
SHORT_URL_BASE='http://jiahao.link/'

function uset() {
  curl -s -H "Accept: application/json" --data-urlencode "url=$1" $SHORT_URL_BASE/$2 | jq ".url//.error" -r
}

function uget() {
  curl -s $SHORT_URL_BASE/$1 | jq ".actual_url//.error" -r
}

function uopen() {
  open "$SHORT_URL_BASE/$1"
}
