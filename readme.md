# configs

```
git clone https://github.com/jszuminski/config ~/.config

npm i -g eslint_d prettier
```

## required symlinks

```bash
ln -s ~/.config/wezterm/wezterm.lua ~/.wezterm.lua
ln -s ~/.config/claude-global-settings ~/.claude/settings.json
```

## other deps

```
brew install pipx
pipx install black
pipx install isort
```

**note:** for personal projects use ruff

## helpful aliases

```
# Modern CLI replacements for speed (used by Claude Code)
alias ls='eza'
alias cat='bat'
alias grep='rg'
alias find='fd'
alias diff='delta'

# Useful for quick Rust development
alias cr="cargo run"
alias cc="cargo check"
```

## cheatsheets
- [tmux](https://tmuxcheatsheet.com/)
- [aerospace](https://cheatography.com/stevend/cheat-sheets/aerospace-window-manager/?last=1734647419)
- [git alias](https://www.hansschnedlitz.com/git-aliases/?ref=xaviergeerinck.com)
- [vimium](https://cheatography.com/l1qu1d/cheat-sheets/vimium/)

## to-do's

- [ ] allow copying from tmux selection mode with cmd+c
- [ ] fix claude code not overriding current buffer
- [ ] create a script which would set everything up (symlinks, tmux, etc.)
- [ ] add makefile which would refresh each and every one piece of config
- [ ] add zshrc common config

