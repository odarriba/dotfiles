source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Plugins to use!.
antigen bundles <<EOBUNDLES

# Aliases and so
git
brew
capistrano
docker
gem
sublime

# Helper for sudo-ing
sudo

# Extraction helper
extract

# nicoulaj's moar completion files for zsh
zsh-users/zsh-completions src

# Syntax highlighting bundle.
zsh-users/zsh-syntax-highlighting

EOBUNDLES

# Load the theme.
antigen theme gallois

# Tell antigen that you're done.
antigen apply

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

source ~/.shell_prompt.sh
source ~/.aliases

export PATH="/usr/local/sbin:$PATH"

