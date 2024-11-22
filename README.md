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
- Neovim: `brew install neovim`
- ripgrep: `brew install ripgrep`
- fd: `brew install fd`
- fzf: `brew install fzf`
- Nerd Fonts: `brew install font-meslo-lg-nerd-font`
    - On iTerm2, under Profiles -> Text, pick `MesloLGS Nerd Font Mono` for `Font`.
- LSPs: `gopls` and `lua-language-server` via Mason (`:MasonInstall`)
- Linters: `goimports`, `gofumpt`, `golangci-lint`, etc via Mason (`:MasonInstall`)

# Troubleshooting
Before you do anything, ensure you `:Lazy` and `U` to update plugins.

Also ensure you: `:MasonUpdate` & `TSUpdate`.

Here is a list of issues I dealt with in the past:
- If `telescope` is not showing preview because of `fzf-native`:
    - Ensure you `:Lazy`, go to `telescope-fzf-native` plugin and hit `gb` to build it
- If `telescope` is not showing Dockerfile previews:
    - Ensure you `:TSInstall dockerfile`
- If edit mode does not autoindent:
    - Ensure you `:TSInstall go`
