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
      ensure_installed = {
        "html",
        "cssls",
        "ts_ls",
        "pyright"
      },
    })

    local lspconfig = require("lspconfig")

    lspconfig.html.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    lspconfig.cssls.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    lspconfig["ts_ls"].setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact"
      },
    })

    lspconfig.pyright.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
  end,
}

