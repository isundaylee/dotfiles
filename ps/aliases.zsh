alias purity='export SKIP_GIT_PROMPT=true; c vm/home/jiahao/work/purity'
alias vmmount='c && sshfs vm:/ vm'
alias vmbr='vmbuildrun'

function vmbuild() {
  ssh vm ". ~/.bash_profile && build '$@'"
}

function vmrun() {
  ssh vm ". ~/.bash_profile && run '$@'"
}

function vmbuildrun() {
  vmbuild "$@" && vmrun "$@"
}