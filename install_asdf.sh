#!/usr/bin/env bash

# install_asdf.sh — ASDF version manager installation script
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname ~)";

echo "ASDF version manager installation script for odarriba's dotfiles";
echo "----------------------------------------------------------------";
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
		echo "[INFO] I'll update homebrew package manager in order to install the required software.";
	else
		echo "[ERROR] Unknown system. Aborting."
		exit;
	fi
}

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing required software...";
	if [[ $platform == 'linux' ]]; then
		sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev
	elif [[ $platform == 'darwin' ]]; then
		brew install automake autoconf openssl libyaml readline libxslt libtool unixodbc
	fi

	# Clone repository
	echo "[INFO] Cloning asdf repository...";
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf;

	case $SHELL in
		*/zsh)
			# assume Zsh
			echo 'autoload bashcompinit' >> ~/.zshrc
			echo 'bashcompinit' >> ~/.zshrc
			echo 'source $HOME/.asdf/asdf.sh' >> ~/.zshrc
			echo 'source $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
			;;
		*/bash)
			if [[ $platform == 'linux' ]]; then
				echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
				echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
			elif [[ $platform == 'darwin' ]]; then
				echo '. $HOME/.asdf/asdf.sh' >> ~/.bash_profile
				echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile
			fi
			;;
	esac

	# Install useful plugins (at least for me :D)
	echo "[INFO] Installing asdf plugins...";
	source $HOME/.asdf/asdf.sh;

	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
	asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git;
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;

}

installBrew() {
	which -s brew
	if [[ $? != 0 ]] ; then
    # Install Homebrew
		echo "[INFO] Installing Homebrew package manager...";
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "[INFO] Updating Homebrew package manager...";
    brew update
	fi
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
