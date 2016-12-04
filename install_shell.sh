#!/usr/bin/env bash

# install_shell.sh — Shell software installation script
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname "${BASH_SOURCE}")";

echo "Linux shell installation script for odarriba's dotfiles";
echo "-------------------------------------------------------";
echo "";

showInfo() {
	echo "";
	echo "[INFO] I'll update your repository caches and perform the installation of required software.";
	echo "[WARNING] This script has been thought to run with APT-like distributions.";
}

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing required software (zsh, git, curl, wget and python-pip)...";
	sudo apt-get install -y -qq vim zsh git-core curl wget python-pip fonts-hack-ttf

	# Change the shell to zsh
	echo "[INFO] Changing the shell of this user to use zsh...";
	chsh -s $(which zsh)

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
	vim +Helptags +q && \
	vim +"PromptlineSnapshot ~/.shell_prompt.sh powerlineclone" +q
}

updateApt() {
	echo "[INFO] Updating APT repositories...";
	sudo apt-get update;
}

doIt() {
	updateApt;
	installSoftware;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "I'm about to install things and change some of your configuration files. Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

echo "";
echo "[INFO] If there isn't any error message, the process is completed. If you want to deploy my configuration files, use deploy.sh script available at my repository.";