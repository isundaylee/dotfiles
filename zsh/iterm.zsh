tabcolor() {
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tabreset() {
  echo -ne "\033]6;1;bg;*;default\a"
}

function ssh {
  tabname "(SSH) `ssh_hostname $1`"
  tabcolor 27 113 250
  /usr/bin/ssh $*
}

