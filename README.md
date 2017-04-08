# odarriba's dotfiles

This repository has several configuration files that I use in my personal computer. They are customised for me, but you can fork, improve or use them if you like.

It includes configuration of *zsh*, *oh-my-zsh*, *asdf-vm* and the configuration.

## usage
In order to use this dotfiles, there is several scripts to make your (and mine) life easier.

**Important note:** The software in this branch is ready to run in a **OSX** based environment.

### installation
To install the shell software, asdf and syncing the configuration, there is a script called `install.sh` that execute commands to do all of these stuff.

**NOTE:** you may want to change the `.gitconfig` file on your local copy (or you will be doing commits with my name and e-mail address).

#### aliases included

Some useful aliases included:

  * `be`: as a shortcut of `bundle exec` (for example, `be rails s` instead of `bundle exec rails s`).
  * `ber`: as a shortcut of `bundle exec take` (for example, `ber db:migrate` instead of `bundle exec rake db:migrate`).
  * `rm_dsstore`: function to remove recursively all the `.DS_Store` files in current folder and subfolders. Useful in external and network units to avoid sending lots of files not useful for non-OSX systems.
  * More... (check `.aliases` file for more aliases)

### contribute
This repository has my dotfiles, but if you find a repo or something to improve, feel free to make a pull request to help me to improve my environment!

### license
This repository is released under the MIT license. See LICENSE file for more information.

### author
This repository is currently maintained by **Óscar de Arriba** (*odarriba at gmail.com*)

[asdf]: https://github.com/asdf-vm/asdf
