# odarriba's dotfiles

This repository has several configuration files that I use in my personal computer. They are customised for me, but you can fork, improve or use them if you like.

It includes configuration of *zsh*, *oh-my-zsh*, *antigen* and *airline*. Also, it provides several setup scripts to make an automatic installation of my personal development environment.

## usage
In order to use this dotfiles, there is several scripts to make your (and mine) life easier.

**Important note:** The software in this branch is ready to run in a **Debian Linux** based environment. If you are using OSX, there is an `osx` branch with a compatible version.

### installation of shell software
To install the shell software, there is a script called `install_shell.sh` that execute commands required to install all the software that I use in my personal environment.

This script is independent of the rest of the repository, and can be called without obtaining all the repository:

`curl -L https://raw.githubusercontent.com/odarriba/dotfiles/master/install_shell.sh | sh`

This installation process is required in order to use the dotfiles because they assume that you have installed:

* zsh
* oh-my-zsh
* antigen (in `~/.antigen/antige.sh`)
* airline (a `powerline` vim version lighter)

### deploy of my dotfiles
To deploy my dotfiles, just execute the `deploy.sh` script, re-login (or execute `zsh`) and enjoy.

#### aliases included

Some useful aliases included:

  * `be`: as a shortcut of `bundle exec` (for example, `be rails s` instead of `bundle exec rails s`).
  * `ber`: as a shortcut of `bundle exec take` (for example, `ber db:migrate` instead of `bundle exec rake db:migrate`).
  * `ms`: as a shortcut of `mix phoenix.server`.
  * `rm_dsstore`: function to remove recursively all the `.DS_Store` files in current folder and subfolders. Useful in external and network units to avoid sending lots of files not useful for non-OSX systems.
  * More... (check `.aliases` file for more aliases)

### install of ASDF version manager

I've recently moved from RBenv to [ASDF][asdf], a new lightweight version manager that support plugins, which allow you to have a unique version manager for multiple software (Ruby, Nodejs, Elixir, PostgreSQL, etc.).

To use it, just execute `install_asdf.sh` script to download dependencies, install ASDF and add it to your profile shell file.

**Note:** if you are going to use `zsh`, you must install ASDF when running zsh, so the install script will recognise the shell you are executing to install auto-completion.

### contribute
This repository has my dotfiles, but if you find a repo or something to improve, feel free to make a pull request to help me to improve my environment!

### license
This repository is released under the MIT license. See LICENSE file for more information.

### author
This repository is currently maintained by **Óscar de Arriba** (*odarriba at gmail.com*)

[asdf]: https://github.com/asdf-vm/asdf
