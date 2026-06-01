# zettel.nvim

Auto-incrementing, template-driven note creation for Zettelkasten-style vaults
in Neovim. Define note types (atoms, molecules, alloys, literature notes, ...),
each with its own template and folder, and create them with a single command.
New notes get the next sequential ID for their folder automatically.

This is the Neovim counterpart to the
[obsidian-zettelkasten](https://github.com/jszuminski/obsidian-zettelkasten)
Obsidian plugin, and works great alongside
[obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim).

## Features

- Sequential, folder-scoped integer IDs (`3314. My note.md` -> next is `3315`).
- Per-type templates and folders; multiple types can share one ID space.
- Template substitutions: `{{title}}`, `{{id}}`, custom placeholders, and the
  Obsidian Templater date helpers `<% tp.file.creation_date("YYYY-MM-DD") %>`
  and `<% tp.file.last_modified_date(...) %>` (resolved natively, no Templater).
- Commands per type plus a `:Zk` picker, and a `require("zettel").create(type)` API.

## Requirements

- Neovim >= 0.10 (uses `vim.fs.dir` with `depth`).

## Installation (lazy.nvim)

```lua
{
  "your-name/zettel.nvim",
  cmd = { "Zk", "ZkAtom", "ZkMolecule", "ZkAlloy" },
  opts = {
    vault = "~/vault",
    folder = "notes",        -- folder (relative to vault) sharing one ID space
    id_separator = ".",      -- "3314. Title.md"
    types = {
      atom     = { template = "_templates/atom.md" },
      molecule = { template = "_templates/molecule.md" },
      alloy    = { template = "_templates/alloy.md" },
    },
  },
}
```

`opts` is passed to `require("zettel").setup()`.

## Configuration

| Option         | Default            | Description                                                        |
| -------------- | ------------------ | ------------------------------------------------------------------ |
| `vault`        | `nil`              | Absolute path to the vault root (supports `~`). Required.          |
| `folder`       | `""`               | Folder (relative to `vault`) that owns the shared ID space.        |
| `id_separator` | `"."`              | Character after the numeric ID.                                    |
| `id_start`     | `1`                | First ID when the folder has no numbered notes.                    |
| `recursive`    | `true`             | Scan subfolders when computing the next ID.                        |
| `open`         | `"edit"`           | Command used to open the new note (`"edit"`, `"vsplit"`, ...).     |
| `date_format`  | `"%Y-%m-%d %H:%M"` | strftime format used for date placeholders.                        |
| `types`        | `{}`               | Map of `name -> { template?, folder? }`.                           |
| `placeholders` | `{}`               | Map of literal string -> replacement (string or `fun(ctx)`).       |

A type's `folder` overrides the global `folder`; omit it to share the ID space.

## Usage

- `:ZkAtom`, `:ZkMolecule`, ... — one command per configured type.
- `:Zk` — pick a type interactively; `:Zk atom` — create directly.
- `require("zettel").create("atom")` — programmatic API.

## License

MIT
