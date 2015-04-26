autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

SEGMENT_SEPARATOR=''

prompt_segment() {
  if [[ -z "$last_used" ]]
  then
    echo -n "$bg[$1]$fg[$2]  $3 "
  else
    echo -n "$bg[$1]$fg[$last_used]$SEGMENT_SEPARATOR $fg[$2]$3 "
  fi
  last_used=$1
}

prompt_end() {
  prompt_segment black white ''
  echo ''
}

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st != "" ]]
  then
    if [[ "$st" =~ "^nothing to commit" ]]
    then
      prompt_segment green black "$(git_prompt_info)"
    else
      prompt_segment red white "$(git_prompt_info)"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
  else
    prompt_segment magenta white 'unpushed'
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    prompt_segment red white "$(ruby_version) "
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

colored_pwd() {
  prompt_segment blue white "$(pwd)"
}

ssh_prompt() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    prompt_segment green black "SSH"
  fi
}

export PROMPT=$'%{$reset_color%}\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
  echo ''
  last_used=''
  ssh_prompt
  rb_prompt
  colored_pwd
  git_dirty
  need_push
  prompt_end
}

set_title() {
  printf "\e]0;$@\a"
}

precmd() {
  # title "zsh" "%m" "%55<...<%~"
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    set_title "(SSH) `hostname`"
  else
    set_title "`basename \`pwd\``"
  fi

  set_prompt
}

# commands to set tab and window names
function tabname {
  printf "\e]1;$1\a"
}

function winname {
  printf "\e]2;$1\a"
}

# SSH that sets tab title properly
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
    *)
      echo $1
      ;;
  esac
}

function ssh {
  tabname "(SSH) `ssh_hostname $1`"
  /usr/bin/ssh $*
}
