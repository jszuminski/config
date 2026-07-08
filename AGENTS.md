# AGENTS.md

## Cursor Cloud specific instructions

This repo is a personal **dotfiles / config** collection (Neovim, tmux, zsh,
WezTerm, AeroSpace, git). There is **no application server, database, or port to
run** — "running it" means using the editor/shell configs and verifying them the
same way CI does (`.github/workflows/ci.yml`).

### Layout
- `nvim/` — Neovim config (lazy.nvim; plugins pinned in `nvim/lazy-lock.json`).
  Includes a bundled local plugin `nvim/zettel.nvim` (pure-Lua Zettelkasten note
  creator; the only "app-like" logic in the repo).
- `tmux/`, `zsh/`, `wezterm/`, `aerospace/`, `git/` — respective tool configs.

### Environment notes (startup layer already run by the update script)
- The update script symlinks `nvim/` to `~/.config/nvim` and runs
  `nvim --headless "+Lazy! restore" +qa` to restore plugins at locked versions.
  System tools (neovim 0.11.2, luajit, zsh, shellcheck) live in the VM snapshot.
- Neovim is pinned to **v0.11.2** (matches CI). The config's treesitter uses the
  frozen `master` branch on purpose (see `nvim/lua/plugins/treesitter.lua`); do
  not switch it to `main`.

### Verifying changes (mirror CI in `.github/workflows/ci.yml`)
- shellcheck: `shellcheck tmux/setup_tmux.sh tmux/tmux-sessionizer`
- lua syntax: `git ls-files '*.lua' | while read -r f; do luajit -e "assert(loadfile('$f'))" || break; done`
- zsh syntax: `for f in zsh/zshrc zsh/zprofile zsh/git-aliases.zsh; do zsh -n "$f"; done`
- nvim boot check: `nvim --headless "+Lazy! restore" +qa` then boot and grep for errors.

### Non-obvious gotchas
- Treesitter parsers auto-install (`auto_install = true`) on first file open and
  compile with the system C compiler. On a brand-new plugin dir this compile is
  noisy and can race if triggered concurrently; to pre-warm deterministically run
  `nvim --headless "+Lazy! load nvim-treesitter" "+TSInstallSync <langs...>" +qa`
  (omit already-installed `query`, which prompts y/n and will hang headless).
- The bundled `zettel.nvim` prompts via `vim.ui.input`/`vim.ui.select`; to drive
  it headlessly, stub those functions before calling `require("zettel").create(...)`.
- Mason LSPs/formatters install on first interactive nvim launch (needs network);
  not required for the CI-style checks above.
