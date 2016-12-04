#!/usr/bin/env bash

# install_asdf.sh — ASDF version manager installation script
# Created by odarriba (https://github.com/odarriba/dotfiles)

cd "$(dirname ~)";

echo "ASDF version manager installation script for odarriba's dotfiles";
echo "----------------------------------------------------------------";
echo "";

installSoftware() {
	# Install zsh and required software
	echo "[INFO] Installing required software...";
	sudo apt-get install -y -qq automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev

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
			source ~/.zshrc
			;;
		*/bash)
			echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
			echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
			source ~/.bashrc
			;;
	esac

	# Install useful plugins (at least for me :D)
	echo "[INFO] Installing asdf plugins...";
	source $HOME/.asdf/asdf.sh;

	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
	asdf plugin-add php https://github.com/odarriba/asdf-php.git;
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
	asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git;
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;

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
	read -p "I'm about to cinstall ASDF software. Do you want to continue? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

echo "";
echo "[INFO] ASDF plugins isntalled: PHP, NodeJS, Ruby, Erlang and Elixir. Please, if you hace a problem with any of them, visit it's github page to search unmet requeriments or issues.'";
echo "[INFO] If there isn't any error message, the process is completed. If you want to deploy my configuration files, use deploy.sh script available at my repository.";
