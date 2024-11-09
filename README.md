## Dotfile repository

Currently a work in progress and most likely will be rewritten

## Table Of Contents
1. [Installation](#installation)
2. [System Packages](#system)
3. [User settings](#user)
4. [Keybindings & Functions](#keybindings-and-functions)
5. [Executables](#executables)

## Installation

* In order to install, do
```bash
curl -X GET https://raw.githubusercontent.com/Lumesque/homemanager-config/master/install.sh | bash
```

## Included packages

### System
1. jq
    * json query tool, very useful for json queries
2. fzf
    * command line fuzzy finder, very fast, very nice
3. ripgrep
    * Faster grep (though syntax is a bit different)
4. zig .13
    * Need to update this to .14
5. rust "2024-08-05"
    * Lastest rust package from august
6. direnv
    * Allow .envrc files in projects for similar build directories
7. xkbcomp
    * Allows for keyboard input layouts in terminal
8. vesktop
    * community discord installation
9. Neovim
    * Uses custom configuraiton for neovim, see that config [here](https://github.com/Lumesque/nixvim-config)
10. Python env. with ipython
    * Allows for fast ipython testing
11. Zen browser
    * Zen browser for all your browsing needs
12. Fish
    * Fish terminal


### User
1. Installs fish, and oh-my-fish themes, change home/shells/fish/default.nix to change theme
2. Installs tmux

### Keybindings and Functions
1. Fish
    1. up
        * up means go 'up' x amount of directories. This takes advantage of expansion in fish so that if you go up 3, your last directory will be the one you left as oppossed to one of the ones inbetween
    2. cdf
        * Look up a file with fzf, and cd into the directory containing that file
    3. home
        * cd home
    4. nf
        * fzf for a file and open it in neovim
    5. ggpush
        * git push to the remote branch of the same name
    6. ff
        * alias to `find . -type f`, or 'find file'
    7. fd
        * alias to `find . -type d`, or 'find directory'
2. tmux
    1. Custom status bar
        * Tmux includes a custom status bar coloring
    2. Vim-key bindings
        * When moving around multiple windows, use 'Ctrl-b' and the corresponding vim motion to move around (k for up, j for down, h for left and l for right)
    3. Paste-buffers
        * Similar copying and pasting to vim. Use 'Ctrl-b [' in order to enter tmux pane, and highlight with 'v' and copy with 'y', and then you can do 'Ctrl-b :choose-buffer' to paste that line in any pane
    4. Mouse support

### Executables
1. dev-tmux
    * Use this to start up tmux with custom setups, with one horizontal split and two vertical or two horizontal splits and one vertical, use `-h` to see more
2. c-qwert
    * Change keyboard layout to qwerty
3. c-dvorak
    * Change keyboard layout to dvorak
4. build-source-command
    * rebuild flake.nix and dotfile configuration
5. build-command
    * JUST rebuild configuration, do not activate
6. home-update-build
    * update the flake to the latest inputs, and rebuild
7. home-pull-build
    * Pull from github and rebuild and source
