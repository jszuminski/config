return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp", -- autocompletions
    "hrsh7th/cmp-nvim-lsp", -- lsp source for nvim-cmp
    "williamboman/mason.nvim", -- lsp manager
    "williamboman/mason-lspconfig.nvim", -- mason-lsp bridge
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "ts_ls" }, -- auto-install TypeScript LSP
    })

    local lspconfig = require("lspconfig")

    lspconfig["ts_ls"].setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
  end,
}

