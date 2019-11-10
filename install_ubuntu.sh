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
	sudo apt-get install -y zsh git-core curl wget python-pip build-essential

	# Change the shell to zsh
	echo "[INFO] Changing the shell of this user to use zsh...";
	chsh -s $(which zsh)

	# Install Oh My Zsh!
	echo "[INFO] Installing Oh My Zsh...";
	curl -L http://install.ohmyz.sh | sh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-custom/plugins/zsh-syntax-highlighting
}

updateApt() {
	echo "[INFO] Updating APT repositories...";
	sudo apt-get update;
}

installAsdf() {
	# Clone repository
	echo "[INFO] Cloning asdf repository...";
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf;

	echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
	echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
	source ~/.bashrc

	# Install required software for ASDF builds
	echo "[INFO] Installing required software for ASDF builds...";
	sudo apt-get install -y git-core curl wget build-essential autoconf unzip libssl-dev libncurses5-dev libreadline-dev zlib1g-dev libsqlite3-dev inotify-tools pkg-config

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
	# Avoid copying gnupg config for OSX on Linux
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude ".gitignore" --exclude "install_fedora.sh" \
	--exclude "install_osx.sh" --exclude "install_ubuntu.sh" --exclude ".gnupg/" --exclude "README.md" \
	--exclude "LICENSE" -avh --no-perms . ~;

}

doIt() {
	updateApt;
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
