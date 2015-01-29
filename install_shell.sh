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
	chsh -s `which zsh`

	# Install Oh My Zsh!
	echo "[INFO] Installing Oh My Zsh...";
	curl -L http://install.ohmyz.sh | sh

	# Install antigen
	echo "[INFO] Installing Antigen...";
	rm -rf ~/.antigen
	git clone https://github.com/zsh-users/antigen ~/.antigen

	# Install powerline
	# echo "[INFO] Installing Powerline...";
	# sudo pip install powerline-status

	# Install airline
	echo "[INFO] Installing Airline (with promptline)...";
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
	git clone https://github.com/edkolev/promptline.vim ~/.vim/bundle/vim-promptline

	# Generating the shell_prompt.sh (first copy the .vimrc)
	cp .vimrc ~/
	vim +Helptags +q
 	vim +"PromptlineSnapshot ~/.shell_prompt.sh powerlineclone" +q
}

installBrew() {
	echo "[INFO] Installing Homebrew package manager...";
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
}

updateApt() {
	echo "[INFO] Updating APT repositories...";
	sudo apt-get update;
}

doIt() {
	if [[ $platform == 'linux' ]]; then
		updateApt;
	elif [[ $platform == 'darwin' ]]; then
		installBrew;
	fi

	installSoftware;
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