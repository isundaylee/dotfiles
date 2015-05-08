alias reload!='. ~/.zshrc'
alias 1803='class 1803'
alias 6006='class 6006'

function class() {
  cd "`find_class $1`"
}
