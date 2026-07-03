-- Proper lua_ls setup for editing this config: injects the nvim runtime and
-- plugin sources into the workspace lazily, so vim.* completion/hover works.
-- (The `globals = { "vim" }` in lsp.lua only silences the undefined-global
-- warning; it does not provide any API types.)
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- load luv (vim.uv) types when the code mentions vim.uv
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
