local ret_status="%(?:C:F)"
local ret_status_git="%(?:G:F)"
function __msdos_pwd() {
  local __path=$(pwd)
  #echo $__path | tr '/' '\\'
  #echo $__path
  echo $__path | sed -r 's/\/home\/dinge+/\/dinge/g'
}
function __get_prefix_chicago95_zsh() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo $ret_status_git;
  else
    echo $ret_status;
  fi
}

#PROMPT='%{$fg_bold[white]%}$(__get_prefix_chicago95_zsh):$(git_prompt_info)$(__msdos_pwd)>%{$reset_color%} '
#
#ZSH_THEME_GIT_PROMPT_PREFIX="\\%{$fg_bold[yellow]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg_bold[white]%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}\\%{$fg_bold[red]%}dirty"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}\\%{$fg_bold[green]%}clean"
# ---------------------------------------------

PROMPT='%{$fg_bold[white]%}$(__get_prefix_chicago95_zsh):$(__msdos_pwd)$(git_prompt_info)>%{$reset_color%} '

#ZSH_THEME_GIT_PROMPT_PREFIX=":("
#ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_PREFIX=":"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
