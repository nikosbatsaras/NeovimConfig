# Installation
Backup current config (if any):
```
mv ~/.config/nvim ~/.config/nvim.bak
```
Install this one:
```
git clone git@github.com:nikosbatsaras/NeovimConfig.git ~/.config/nvim
```

# Dependencies
For MacOS via [Homebrew](https://brew.sh/):
- neovim: `brew install neovim`
- ripgrep: `brew install ripgrep`
- fd: `brew install fd`
- nerd-fonts:
    ```
    brew tap homebrew/cask-fonts
    brew install font-meslo-lg-nerd-font
    ```
    On iTerm2, under Profiles -> Text, pick `MesloLGS Nerd Font Mono` for `Font`.
- Install `gopls` and `lua-language-server` via Mason (`:Mason`)

# Troubleshooting
Before you do anything, ensure you `:Lazy` and `U` to update plugins.

Here is a list of issues I dealt with in the past:
- If `telescope` is not showing preview because of `fzf-native`:
    - Ensure you `:Lazy`, go to `telescope-fzf-native` plugin and hit `gb` to build it
- If `telescope` is not showing Dockerfile previews:
    - Ensure you `:TSInstall dockerfile`
- If edit mode does not autoindent:
    - Ensure you `:TSInstall go`
