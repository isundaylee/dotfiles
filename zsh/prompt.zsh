autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
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
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
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
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

colored_pwd() {
  echo "%{$fg_bold[cyan]%}$(pwd)/%{$reset_color%}"
}

ssh_prompt() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "%{$fg_bold[red]%}(SSH)%{$reset_color%} "
  fi
}

export PROMPT=$'\n$(ssh_prompt)$(rb_prompt)in $(colored_pwd) $(git_dirty)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

set_title() {
  printf "\e]0;$@\a"
}

precmd() {
  # title "zsh" "%m" "%55<...<%~"
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    set_title "(SSH) `hostname`"
  else
    set_title "`hostname`"
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