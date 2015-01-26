#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

echo "Deploy script for odarriba's dotfiles";
echo "-------------------------------------";
echo "";
echo "- Getting the lastest changes from my GitHub repo...";
# git pull origin master;

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
		echo "I've detected that you're running Linux. ";
		echo "I'll update your repository caches and perform the installation of required software in order to install the base system.";
		echo "WARNING: This script has been thought to run with APT-like distributions.";
	elif [[ $platform == 'darwin' ]]; then
		echo "I've detected that you're running OSX.";
		echo "I'll install homebrew package manager in order to install the required software of the base system.";
	else
		echo "Unknown system. Aborting."
		exit;
	fi
}

rsyncFiles() {
	echo "- Syncing configuration...";
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude ".gitignore" --exclude "deploy.sh" \
		--exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~;
}

installSoftware() {
	echo "- Installing required software...";
	# Install zsh and required software
	if [[ $platform == 'linux' ]]; then
		sudo apt-get install -y zsh git-core curl wget
	elif [[ $platform == 'darwin' ]]; then
		brew install zsh curl wget python
	fi

	# Install Oh My Zsh!
	curl -L http://install.ohmyz.sh | sh

	# Change the shell to zsh
	chsh -s `which zsh`

	# Install antigen
	rm -rf ~/.antigen
	git clone https://github.com/zsh-users/antigen ~/.antigen

	# Install powerline
	pip install powerline-status
}

installBrew() {
	echo "- Installing Homebrew package manager...";
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
}

updateApt() {
	echo "- Updating APT repositories...";
	sudo apt-get update;
}

doIt() {
	if [[ $platform == 'linux' ]]; then
		updateApt;
	elif [[ $platform == 'darwin' ]]; then
		installBrew;
	fi

	installSoftware;

	rsyncFiles;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	showInfo;
	read -p "Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;