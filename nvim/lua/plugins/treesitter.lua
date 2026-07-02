return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "typescript", "tsx", "javascript", "json", "jsonc",
        "html", "css", "astro", "svelte",
        "bash", "python", "go", "rust", "sql",
        "markdown", "markdown_inline", "yaml", "toml",
        "gitcommit", "gitignore", "diff",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        -- <CR>/<BS>: <C-Space> is the tmux prefix, so tmux swallows it
        -- before nvim ever sees the key and the binding is unreachable.
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
    })
  end,
}
