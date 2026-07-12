# Neovim config

Personal daily-driver Neovim setup (pinned to **0.11.x**). Lean plugin set,
native LSP APIs, fzf-lua for picking, oil for files, and a local Zettelkasten
plugin for the Obsidian vault.

Leader is **Space**. Local leader is also Space.

## Layout

```
nvim/
├── init.lua                 # bootstrap: loader, leader, lazy.nvim
├── lazy-lock.json           # pinned plugin commits (commit after :Lazy update)
├── lua/config/
│   ├── options.lua          # vim.opt / providers
│   ├── keymaps.lua          # global maps (non-plugin)
│   └── autocmds.lua         # yank highlight, trailing WS, wrap, checktime, hl
├── lua/plugins/             # one file per plugin (or small group)
└── zettel.nvim/             # bundled local plugin (note creation)
```

`require("lazy").setup("plugins", …)` auto-loads every file under
`lua/plugins/`.

## Mental model

| Job | Tool |
|---|---|
| Find files / grep / LSP pickers | **fzf-lua** |
| File explorer / rename / mkdir | **oil** (`-` or `<leader>e`) |
| Completion + snippets | **blink.cmp** + friendly-snippets |
| LSP install | **Mason** + mason-tool-installer (`tool@version` pins) |
| LSP enable/config | native `vim.lsp.config` / `vim.lsp.enable` + nvim-lspconfig catalog |
| Format on save | **conform** (JS/TS excluded — use `<leader>cf`) |
| Git hunks | **gitsigns** |
| Notes (vault search / `[[`) | **obsidian.nvim** (only under `~/Documents/jsafe`) |
| Notes (typed Zettel IDs) | **zettel.nvim** (`<leader>z*`) |
| Surround / textobjects / pairs | **mini.surround** / **mini.ai** / **mini.pairs** |
| Undo history | **undotree** |
| Yank ring | **yanky** |
| Tmux panes | **vim-tmux-navigator** (`C-hjkl`) |

## Plugins (brief)

| Plugin | What it does here |
|---|---|
| **lazy.nvim** | Plugin manager; checker off; rtp trimmed (no netrw/gzip/…) |
| **blink.cmp** | Completion (LSP, path, snippets, buffer); ghost text; signature help |
| **friendly-snippets** | Snippet pack for blink’s `"snippets"` source |
| **nvim-lspconfig** | Server config catalog consumed by `vim.lsp.enable` |
| **mason.nvim** | UI + install root for LSPs/formatters |
| **mason-tool-installer** | Auto-install pinned tools on start (skipped in CI) |
| **fzf-lua** | Fuzzy finder for files, grep, buffers, git, LSP, diagnostics |
| **oil.nvim** | Buffer-as-directory explorer; replaces netrw |
| **conform.nvim** | Formatters (stylua, ruff, prettierd, …); `:FormatToggle` |
| **nvim-treesitter** | Highlight / indent / incremental selection (`master` branch — see below) |
| **nvim-treesitter-textobjects** | Query files only; used by mini.ai (`f`/`c`/`o`) |
| **mini.ai** | Better `a`/`i` textobjects + treesitter function/class/block |
| **mini.surround** | Surround with `gs*` (keeps bare `s` as substitute) |
| **mini.pairs** | Autopairs |
| **gitsigns.nvim** | Signcolumn hunks + stage/reset/blame maps |
| **yanky.nvim** | Persistent yank ring; cycle with `]y`/`[y`; browse with `<leader>fy` |
| **lualine.nvim** | Statusline (matrix-ish green-on-black theme) |
| **which-key.nvim** | Leader group labels (`f` find, `c` code, `z` zettel, …) |
| **undotree** | Visual undo tree (`undofile` is on) |
| **vim-tmux-navigator** | Seamless `C-hjkl` across nvim splits and tmux panes |
| **lazydev.nvim** | lua_ls types for editing this config |
| **obsidian.nvim** | Vault search, backlinks, `[[` completion (frontmatter writes disabled) |
| **zettel.nvim** | Local: sequential IDs + templates for atoms/molecules/alloys/literature |
| **colorschemes** | `ansi_blows` (active), plus matrix / vividchalk / borlandp installed |

## Languages / tools

Installed via Mason (pins in `lua/plugins/lsp.lua`):

- **Lua** — lua-language-server, stylua
- **TS/JS** — vtsls, eslint-lsp, prettierd (manual format for JS/TS)
- **Web** — json/html/css LSPs, tailwind, astro, svelte
- **Python** — basedpyright, ruff (format + organize imports on save)
- **Rust** — rust-analyzer (`cargo check` on save; inlays off until `<leader>uh`)
- **C** — clangd (format on save via clangd's built-in clang-format; respects `.clang-format`)

Treesitter also installs parsers for go/sql/bash/yaml/toml/markdown/git, etc.
There is **no Go LSP** configured — only the parser.

## Notable behaviors

- **Diagnostics:** compact `●` virtual text on other lines; full message as
  virtual lines on the *current* line.
- **Format on save:** on for Lua/Python/web/markdown/yaml; **off** for
  JS/TS/JSX/TSX (still `<leader>cf`). Toggle with `:FormatToggle` / `:FormatToggle!`.
- **Obsidian** loads only for `~/Documents/jsafe/**.md` (or via `<leader>o*`).
- **Zettel vs Obsidian:** use `<leader>z*` for typed ID notes; `<leader>o*` for
  vault search / backlinks / `[[` workflow. Prefer zettel for “new atom”, not
  `<leader>on`, if you want sequential IDs.
- **Treesitter** stays on the frozen `master` branch while on Neovim 0.11.
  Migrating to `main` is a deliberate step with Neovim 0.12.
- **Theme:** change `ACTIVE` in `lua/plugins/colorscheme.lua`, restart.
- **Trailing whitespace** stripped on save except markdown/mail/diff/git.
- **Soft wrap** for markdown, text, gitcommit, mail, svelte, rust.

## Maintenance

```bash
# After :Lazy update
# commit nvim/lazy-lock.json

# Bump Mason pins: edit tool@version in lua/plugins/lsp.lua, then
:MasonToolsUpdate
```

CI (`.github/workflows/ci.yml`) runs lua syntax checks and a headless
`Lazy! restore` + boot.

---

## Cheatsheet

`<leader>` = `Space`.

### Core

| Key | Action |
|---|---|
| `<leader>w` | Save |
| `<leader>q` / `Q` | Quit / quit all |
| `<Esc>` | Clear search highlight |
| `<S-h>` / `<S-l>` | Prev / next buffer |
| `<leader>bd` | Delete buffer |
| `<leader>uw` | Toggle wrap |
| `<leader>uu` | Undo tree |
| `<C-d>` / `<C-u>` | Half-page (centered) |
| `n` / `N` | Next / prev match (centered) |

### Find (fzf-lua)

| Key | Action |
|---|---|
| `<C-p>` / `<leader><space>` / `<leader>ff` | Files |
| `<leader>fg` | Live grep |
| `<leader>fG` | Grep word under cursor |
| `<leader>/` | Grep current buffer |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fs` / `fS` | Symbols (buffer / workspace) |
| `<leader>fd` | Workspace diagnostics |
| `<leader>fh` / `fk` / `fc` | Help / keymaps / commands |
| `<leader>fy` | Yank history (Yanky ring) |
| `<C-q>` (in fzf) | Send all matches to quickfix |

### Files (oil)

| Key | Action |
|---|---|
| `-` / `<leader>e` | Open oil (parent dir) |
| `<CR>` | Open |
| `-` (in oil) | Parent |
| `<C-s>` | Open vertical |
| `g.` | Toggle hidden |
| `q` / `<C-c>` | Close |

### LSP / code

| Key | Action |
|---|---|
| `gd` / `gD` | Definition / declaration |
| `gr` / `gI` / `gy` | References / implementations / type def |
| `K` | Hover |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>cs` | Signature help |
| `<leader>cf` | Format (conform) |
| `<leader>cd` | Line diagnostics float |
| `]d` / `[d` | Next / prev diagnostic |
| `<leader>uh` | Toggle inlay hints |

### Git

| Key | Action |
|---|---|
| `]c` / `[c` | Next / prev hunk |
| `<leader>hs` / `hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` / `ht` | Blame line / toggle blame |
| `<leader>hd` | Diff this |
| `<leader>gs` / `gc` / `gb` | Status / commits / branches (fzf) |

### Yank

| Key | Action |
|---|---|
| `y` / `p` / `P` | Yank / put (via Yanky) |
| `]y` / `[y` | Cycle yank ring after put |
| `<leader>p` (visual) | Paste without yanking |
| `<leader>d` | Delete without yanking |
| `<leader>fy` | Fuzzy yank history |

### Edit helpers

| Key | Action |
|---|---|
| `gsa` / `gsd` / `gsr` | Surround add / delete / replace |
| `vaf` / `vif` | Around / inside function (treesitter) |
| `vac` / `vic` | Around / inside class |
| `vao` / `vio` | Around / inside loop or conditional |
| `<CR>` / `<BS>` (normal) | Treesitter incremental selection expand / shrink |
| `J` / `K` (visual) | Move selection down / up |

### Navigation / lists

| Key | Action |
|---|---|
| `C-h/j/k/l` | Move across nvim splits **or** tmux panes |
| `]q` / `[q` | Next / prev quickfix |
| `<leader>xq` | Toggle quickfix |

### Notes

| Key | Action |
|---|---|
| `<leader>oo` | Obsidian search |
| `<leader>oq` | Quick switch note |
| `<leader>ob` / `ol` | Backlinks / links in buffer |
| `<leader>on` | Obsidian new (slug name — not zettel ID) |
| `<leader>zz` | Zettel: pick type |
| `<leader>za` / `zm` / `zy` / `zl` | Atom / molecule / alloy / literature |
| `<leader>zr` / `zt` / `zo` | Set reading / set topic / open reading |

### Completion (insert, blink default preset)

| Key | Action |
|---|---|
| `<C-y>` | Accept |
| `<C-n>` / `<C-p>` | Next / prev item |
| `<C-e>` | Cancel |
| `<C-b>` / `<C-f>` | Scroll docs |

(Exact blink preset keys: see `:h blink-cmp-keymap` or `<leader>fk`.)
