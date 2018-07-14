# Depends on the git plugin for work_in_progress()
WHITE_COLOR=007
ERROR_CODE_COLOR=001

ZSH_THEME_GIT_PROMPT_PREFIX="  "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}%{$bg[yellow]$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{$bg[green]$fg_bold[white]%}"
EXIT_CODE_PROMPT="%(?..$FG[$ERROR_CODE_COLOR]$BG[$ERROR_CODE_COLOR]$FG[$WHITE_COLOR] %? )"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Combine it all into a final right-side prompt
RPS1='$EXIT_CODE_PROMPT$(git_custom_status)%{$reset_color%}$EPS1'

PROMPT='%{$bg_bold[blue]$fg_bold[white]%} %n %{$reset_color$bg[grey]$fg[blue]%}%{$fg_bold[white]%} %1~ %{$reset_color$fg[grey]%}%{$reset_color%} '
