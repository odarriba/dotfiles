#!/usr/bin/env bash

# install_shell.sh — Shell software installation script
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname "${BASH_SOURCE}")";

echo "Shell installation script for odarriba's dotfiles";
echo "-------------------------------------------------";
echo "";

platform='undefined'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
	platform='darwin'
fi

showInfo() {
	echo "";
	if [[ $platform == 'linux' ]]; then
		echo "[INFO] I've detected that you're running Linux. ";
		echo "[INFO] I'll update your repository caches and perform the installation of required software.";
		echo "[WARNING] This script has been thought to run with APT-like distributions.";
	elif [[ $platform == 'darwin' ]]; then
		echo "[INFO] I've detected that you're running OSX.";
		echo "[INFO] I'll install homebrew package manager in order to install the required software.";
	else
		echo "[ERROR] Unknown system. Aborting."
		exit;
	fi
}

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing required software (zsh, git, curl, wget and python-pip)...";
	if [[ $platform == 'linux' ]]; then
		sudo apt-get install -y zsh git-core curl wget python-pip
	elif [[ $platform == 'darwin' ]]; then
		brew install zsh git curl wget python vim
	fi

	# Change the shell to zsh
	echo "[INFO] Changing the shell of this user to use zsh...";
	if [[ $platform == 'darwin' ]]; then # OSX hack
		echo $(which zsh) | sudo tee -a /etc/shells
	fi
	chsh -s $(which zsh)

	# Install Oh My Zsh!
	echo "[INFO] Installing Oh My Zsh...";
	curl -L http://install.ohmyz.sh | sh
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

	# Install useful plugins (at least for me :D)
	echo "[INFO] Installing asdf plugins...";
	source $HOME/.asdf/asdf.sh;

	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
	asdf plugin-add php https://github.com/odarriba/asdf-php.git;
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
	asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git;
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;
}

syncConfig() {
	echo "[INFO] Syncing configuration...";
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude ".gitignore" --exclude "install.sh" \
	--exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~;
}

doIt() {
	if [[ $platform == 'linux' ]]; then
		updateApt;
	elif [[ $platform == 'darwin' ]]; then
		installBrew;
		updateBrew;
	fi

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
echo "[INFO] If there isn't any error message, the process is completed. If you want to deploy my configuration files, use deploy.sh script available at my repository.";
