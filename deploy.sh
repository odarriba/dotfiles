#!/usr/bin/env bash

# deploy.sh — Dotfiles deploy script
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname "${BASH_SOURCE}")";

echo "Deploy script for odarriba's dotfiles";
echo "-------------------------------------";
echo "";
echo "[INFO] Getting the lastest changes from my GitHub repo...";
git pull origin master;

rsyncFiles() {
	echo "[INFO] Syncing configuration...";
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude ".gitignore" --exclude "deploy.sh" --exclude "install_shell.sh" \
		--exclude "user.sublime-settings" --exclude "atom_config.cson" --exclude "osx_config.sh" --exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~;
}


if [ "$1" == "--force" -o "$1" == "-f" ]; then
	rsyncFiles;
else
	echo "";
	read -p "I'm about to change the configuration files placed in your home directory. Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rsyncFiles;
	fi;
fi;
