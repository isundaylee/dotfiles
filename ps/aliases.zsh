alias purity='export SKIP_GIT_PROMPT=true; c vm/home/jiahao/work/purity'
alias vmmount='c && sshfs vm:/ vm'
alias vmbr='vmbuildrun'


alias build="cd $HOME/work/purity && make -j 4 CC=\"distcc gcc\" -C ../bld_linux/purity"
alias lbuild="cd $HOME/work/purity && make -j 4 -C ../bld_linux/purity"

function vmbuild() {
  if (( $# == 0 )) then
    ssh vm ". ~/.bash_profile && build"
  else
    ssh vm ". ~/.bash_profile && build '$@'"
  fi
}

function vmrun() {
  ssh vm ". ~/.bash_profile && run '$@'"
}

function vmbuildrun() {
  vmbuild "$@" && vmrun "$@"
}
