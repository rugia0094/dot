# dot

A list of dot files to setup dev enviroment. (Ubuntu)

## Before install

### 1. Install requirements

lua5.3 - lua language version 5.3
liblua5.3-dev - lua headers
neovim - text editor
python3-neovim - python support for neovim
lynx - terminal browser
unzip - archive utilite
xclip - copy/paste to clipboard in tmux

```shell
$ sudo apt install lua5.3 liblua5.3-dev neovim python3-neovim lynx unzip xclip
```

### 2. Install luarocks

Follow guide from here (https://luarocks.org/)

## Install

Run in project root

```shell
$ ./setup
```

It may need to `chmod +x setup` for all of setup files in subdirectories
