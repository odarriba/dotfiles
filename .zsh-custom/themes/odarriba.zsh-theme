# Depends on the git plugin for work_in_progress()
WHITE_COLOR=007
BLUE_COLOR=004
GREY_COLOR=240
ELIXIR_COLOR=093
GIT_DIRTY_COLOR=005
GIT_CLEAN_COLOR=002

ZSH_THEME_GIT_PROMPT_PREFIX="  "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[$GIT_DIRTY_COLOR]%}%{$BG[$GIT_DIRTY_COLOR]$FG[$WHITE_COLOR]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[$GIT_CLEAN_COLOR]%}%{$BG[$GIT_CLEAN_COLOR]$FG[$WHITE_COLOR]%}"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
elixir_version() {
  if hash elixir 2>/dev/null; then
    ELIXIR_VERSION=`elixir -v | sed -n -e 's/^.*Elixir //p'`
    echo "%{$FG[$ELIXIR_COLOR]%}%{$BG[$ELIXIR_COLOR]$FG[$WHITE_COLOR]%} Elixir $ELIXIR_VERSION "
  fi
}

# Combine it all into a final right-side prompt
RPS1='$(git_custom_status)$(elixir_version)%{$reset_color%} $EPS1'

PROMPT='%{$BG[$BLUE_COLOR]$FG[$WHITE_COLOR]%} %n %{$BG[$GREY_COLOR]$FG[$BLUE_COLOR]%}%{$FG[$WHITE_COLOR]%} %1~ %{$reset_color$FG[$GREY_COLOR]%}%{$reset_color%} '
