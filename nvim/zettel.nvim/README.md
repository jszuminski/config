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
- Prompted fields: a type can ask for extra values (author, status, ...) and
  fill them straight into the note's YAML frontmatter, no placeholder tokens needed.
- "Currently reading" / "current topic" pointers: persisted per vault, settable
  via a picker (fzf-lua if present, else `vim.ui.select`), and substituted into
  templates wherever the `currently_reading` / `current_topic` tokens appear.
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
| `types`        | `{}`               | Map of `name -> { template?, folder?, fields?, set_reading_when? }`. |
| `placeholders` | `{}`               | Map of literal string -> replacement (string or `fun(ctx)`).       |
| `link_format`  | `'"[[name]]"'`     | How `currently_reading` / `current_topic` render in templates.     |
| `reading_folder` | `nil`            | Folder to pick the currently-reading note from.                    |
| `topic_folder` | `nil`              | Folder to pick the current-topic note from (defaults to the vault).|

A type's `folder` overrides the global `folder`; omit it to share the ID space.

### Prompted fields

A type can prompt for extra fields and fill them into the note's frontmatter:

```lua
literature = {
  template = "_templates/literature.md",
  folder = "Literature",
  fields = {
    { key = "author", prompt = "Author(s)", list = true },       -- comma-separated -> YAML list
    { key = "status", prompt = "Status", type = "select",
      choices = { "currently-reading", "read", "want-to-read" }, default = "currently-reading" },
    { key = "pages",  prompt = "Pages" },
  },
  set_reading_when = { field = "status", equals = "currently-reading" },
}
```

`fields` fill existing frontmatter keys (`author:`, `status:`, ...) in place, so
your template stays a normal template. `set_reading_when` points the
`currently_reading` pointer at the new note when a field matches.

## Usage

- `:ZkAtom`, `:ZkMolecule`, `:ZkLiterature`, ... — one command per configured type.
- `:Zk` — pick a type interactively; `:Zk atom` — create directly.
- `:ZkSetReading` / `:ZkSetTopic` — set the currently-reading / current-topic note.
- `:ZkReading` — open the currently-reading note.
- `require("zettel").create("atom")` — programmatic API.

## License

MIT
