# odarriba's dotfiles

This repository has several configuration files that I use in my personal computer. They are mine, but you can fork, improve or use them if you like.

It includes configuration of *zsh*, *oh-my-zsh*, *antigen* and *powerline*. Also, it provides several setup scripts to make an automatic installation of my personal development environment.

### usage
In order to use this dotfiles, there is several scripts to make your (and mine) life easier.

#### installation of required software
To install the required software, there is a script called `install_shell.sh` that execute the commands required in order to obtain a base system compatible with the dotfiles of this repo.

This script is independent of the rest of the repository, and can be called without obtaining all the repository:

`curl -L https://raw.githubusercontent.com/odarriba/dotfiles/master/install_shell.sh | sh`

This installation process is required in order to use the dotfiles because they assume that you have installed:

* zsh
* oh-my-zsh
* antigen (in `~/.antigen/antige.sh`)
* powerline (installed via `pip` and not in user-space)

#### deploy of my dotfiles
To deploy my dotfiles, just execute the `deploy.sh` script, re-login (or execute `zsh`) and enjoy.

### contribute
This repository has my dotfiles, but if you find a repo or something to improve, feel free to make a pull request to help me to improve my environment!

### license
This repository is released under the MIT license. See LICENSE file for more information.

### author
This repository is currently maintained by **Óscar de Arriba** (*odarriba at gmail.com*)
