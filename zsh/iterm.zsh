tabcolor() {
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tabreset() {
  echo -ne "\033]6;1;bg;*;default\a"
}

# SSH that sets tab title and tab color properly

function ssh_hostname {
  case $1 in
    l)
      echo "Linode"
      ;;
    a)
      echo "Athena"
      ;;
    d)
      echo "Digital Ocean"
      ;;
    gce)
      echo "Google Cloud Engine"
      ;;
    bd)
      echo "BeaverDash"
      ;;
    dokku)
      echo "Dokku"
      ;; 
    *)
      echo $1
      ;;
  esac
}

function ssh_color {
  case $1 in
    vtb)
      echo "27 113 250"
      ;;
    vma)
      echo "255 64 64"
      ;;
    *)
      echo "27 113 250"
      ;;
  esac
}

function ssh {
  tabname "(SSH) `ssh_hostname $1`"
  tabcolor `ssh_color $1`
  /usr/bin/ssh $*
}

