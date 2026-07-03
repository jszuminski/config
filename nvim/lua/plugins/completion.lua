return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  -- stay on 1.x releases; a 2.0 should be a deliberate migration
  version = "1.*",
  opts = {
    keymap = { preset = "default" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = "rounded",
        draw = { treesitter = { "lsp" } },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
        markdown = { "lsp", "path", "snippets" },
        text = { "path" },
        gitcommit = { "path" },
      },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    signature = { enabled = true, window = { border = "rounded" } },
  },
}
