#!/usr/bin/env bash

# install.sh — Installation script for odarriba's dotfiles
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname "${BASH_SOURCE}")";

echo "Installation script for odarriba's dotfiles";
echo "-------------------------------------------------";
echo "";

installSoftware() {
  # Install zsh and required software
  echo "[INFO] Installing required software (zsh, git, curl, wget...)";
  brew install git fish curl wget coreutils gpg gnupg automake autoconf openssl rar

  echo "[INFO] Installing required fonts (Cascadia Code, Hack)";
  brew install --cask font-cascadia-code-pl font-cascadia-mono font-cascadia-mono-pl font-cascadia-code font-hack

  # Change the shell to zsh
  echo "[INFO] Changing the shell of this user to use fish...";
  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)

  # Install Fisher
  echo "[INFO] Installing Fisher...";
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  echo "[INFO] Installing Tide prompt...";
  fish -c "fisher install IlanCosman/tide@v6"
  fish -c "tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No"
}

installBrew() {
  if hash brew 2>/dev/null; then
    echo "[INFO] Brew already installed."
  else
    echo "[INFO] Installing Homebrew package manager...";
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
  fi
}

updateBrew() {
  if hash brew 2>/dev/null; then
    echo "[INFO] Updating Homebrew package manager...";
    brew update;
  fi
}

installMise() {
  # Clone repository
  echo "[INFO] Installing mise...";
  curl https://mise.run | MISE_QUIET=1 sh

  echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish
  ~/.local/bin/mise completion fish > ~/.config/fish/completions/mise.fish
}

syncConfig() {
  echo "[INFO] Syncing configuration...";
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude ".gitignore" \
  --exclude "install.sh" --exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~;
}

doIt() {
  installBrew;
  updateBrew;
  installSoftware;
  syncConfig;
  installMise;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "I'm about to change the configuration files placed in your home directory. Do you want to continue? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;

echo "";
echo "[INFO] If there isn't any error message, the process is completed.";
