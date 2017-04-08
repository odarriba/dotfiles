# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom/
ZSH_THEME="odarriba"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(asdf bower brew bundler c common-aliases composer docker docker-compose extract gem git heroku kubectl mix node npm postgres powder rails ruby ssh-agent yarn elixir)

source $ZSH/oh-my-zsh.sh

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

source ~/.aliases

export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
autoload bashcompinit
bashcompinit
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
