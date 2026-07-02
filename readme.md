# configs

```
git clone https://github.com/jszuminski/config ~/.config
```

Formatters and language servers (prettierd, ruff, stylua, LSPs, ...) are
installed automatically by Mason on first nvim launch - no npm/pipx
installs needed.

## required symlinks

```bash
ln -s ~/.config/wezterm/wezterm.lua ~/.wezterm.lua
ln -s ~/.config/zsh/zshrc ~/.zshrc
ln -s ~/.config/zsh/zprofile ~/.zprofile
ln -s ~/.config/claude-global-settings.json ~/.claude/settings.json  # gitignored, machine-local
```

## shell

Zsh config lives in `zsh/` (no oh-my-zsh; the git aliases are extracted
into `zsh/git-aliases.zsh`). Aliases, prompt, and lazy-loaded nvm are all
in `zsh/zshrc`.

## version pinning

- **nvim plugins:** pinned via `nvim/lazy-lock.json` (commit it after every `:Lazy update`)
- **tmux plugins:** pinned to release tags in `tmux/tmux.conf` (`plugin#vX.Y.Z`)
- **mason tools:** not pinned yet (mason-tool-installer supports `tool@version`)

## other vim improvements

- bind Caps Lock to Esc on MacOS (System Settings -> Keyboard -> Keyboard Shortcuts -> Modifier Keys -> Caps Lock, rebind to Escape)

## cheatsheets

- [tmux](https://tmuxcheatsheet.com/)
- [aerospace](https://cheatography.com/stevend/cheat-sheets/aerospace-window-manager/?last=1734647419)
- [git alias](https://www.hansschnedlitz.com/git-aliases/?ref=xaviergeerinck.com)
- [vimium](https://cheatography.com/l1qu1d/cheat-sheets/vimium/)

## to-do's

- [ ] create a setup script + Brewfile which would set everything up (brew deps, symlinks, tmux, caps-lock remap)
- [ ] unify personal/work nvim + tmux configurations
- [ ] fix claude code not overriding current buffer
- [ ] pin mason tool versions
- [ ] trim unused aerospace alt-letter workspace bindings
- [x] add zshrc common config
- [x] allow copying from tmux selection mode (`y` in copy mode now pipes to pbcopy)
- [x] use fixed versions of plugins (lazy-lock.json for nvim, `#tag` pins for tmux)
