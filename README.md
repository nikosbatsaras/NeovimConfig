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
- nerd-fonts:
    ```
    brew tap homebrew/cask-fonts
    brew install font-meslo-lg-nerd-font
    ```
    On iTerm2, under Profiles -> Text, pick `MesloLGS Nerd Font Mono` for `Font`.
