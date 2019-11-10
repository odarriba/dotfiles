#!/usr/bin/env bash

# install_shell.sh — Shell software installation script
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname "${BASH_SOURCE}")";

echo "Shell installation script for odarriba's dotfiles";
echo "-------------------------------------------------";
echo "";

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing required software (zsh, git, curl, wget and python-pip)...";
	brew install zsh git curl wget python vim coreutils gpg pinentry-mac gnupg automake autoconf openssl libyaml readline libxslt libtool unixodbc wxwidgets

	# Change the shell to zsh
	echo "[INFO] Changing the shell of this user to use zsh...";
	echo $(which zsh) | sudo tee -a /etc/shells
	chsh -s $(which zsh)

	# Install Oh My Zsh!
	echo "[INFO] Installing Oh My Zsh...";
	curl -L http://install.ohmyz.sh | sh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-custom/plugins/zsh-syntax-highlighting
}

installBrew() {
	if hash elixir 2>/dev/null; then
		echo "[INFO] Brew already installed."
	else
		echo "[INFO] Installing Homebrew package manager...";
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
	fi
}

updateBrew() {
	if hash elixir 2>/dev/null; then
		echo "[INFO] Updating Homebrew package manager...";
		brew update;
	fi
}

installAsdf() {
	# Clone repository
	echo "[INFO] Cloning asdf repository...";
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf;

	echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
	echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
	source ~/.bashrc

	# Install useful plugins (at least for me :D)
	echo "[INFO] Installing asdf plugins...";
	source $HOME/.asdf/asdf.sh;

	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
	bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring;
	asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git;
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;
	asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git;
	asdf plugin-add packer https://github.com/Banno/asdf-hashicorp.git;
}

syncConfig() {
	echo "[INFO] Syncing configuration...";
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude ".gitignore" --exclude "install_fedora.sh" \
	--exclude "install_osx.sh" --exclude "install_ubuntu.sh" --exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~;
}

doIt() {
	installBrew;
	updateBrew;
	installSoftware;
	syncConfig;
	installAsdf;
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
