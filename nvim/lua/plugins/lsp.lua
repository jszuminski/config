return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
  },
  -- Install binaries only. Servers are enabled below via vim.lsp.enable();
  -- mason-lspconfig is intentionally omitted (it had empty ensure_installed
  -- and automatic_enable = false, so it added load cost for no benefit).
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Pinned versions for reproducible installs on a fresh machine.
      -- To upgrade: bump the version here, then :MasonToolsUpdate.
      ensure_installed = {
        "lua-language-server@3.9.3",
        "vtsls@0.2.6",
        "eslint-lsp@4.10.0",
        "json-lsp@4.10.0",
        "html-lsp@4.10.0",
        "css-lsp@4.10.0",
        "tailwindcss-language-server@0.0.17",
        "astro-language-server@2.16.7",
        "svelte-language-server@0.16.11",
        "basedpyright@1.39.9",
        "ruff@0.6.8",
        "rust-analyzer@2025-02-24",
        "stylua@v0.20.0",
        "prettierd@0.27.0",
      },
      -- skip in CI: the boot test doesn't need 14 tool downloads
      run_on_start = not vim.env.CI,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.diagnostic.config({
        -- Compact dot inline on every line except the current one...
        virtual_text = { prefix = "●", spacing = 2, current_line = false },
        -- ...where the full diagnostic renders below the line as wrapped
        -- virtual lines, so long errors are readable in a narrow window.
        virtual_lines = { current_line = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true, wrap = true, max_width = 80 },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("jacob-lsp", { clear = true }),
        callback = function(args)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc, silent = true })
          end

          -- Render inlay hints (the rust-analyzer settings below configure
          -- WHAT to show; without this enable nothing is displayed at all).
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
          map("n", "<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
          end, "Toggle inlay hints")
          map("n", "gd", function() require("fzf-lua").lsp_definitions() end, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", function() require("fzf-lua").lsp_references() end, "References")
          map("n", "gI", function() require("fzf-lua").lsp_implementations() end, "Implementations")
          map("n", "gy", function() require("fzf-lua").lsp_typedefs() end, "Type definition")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cs", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

      -- Neovim 0.11 native LSP API (vim.lsp.config/enable) instead of the
      -- deprecated require("lspconfig").<server>.setup() framework.
      -- Apply blink capabilities to every server via the "*" default.
      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        },
      })

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoImportCompletions = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      vim.lsp.config("ruff", {
        init_options = {
          settings = { lineLength = 100 },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = "clippy" },
            inlayHints = {
              parameterHints = { enable = true },
              typeHints = { enable = true },
              chainingHints = { enable = true },
            },
          },
        },
      })

      vim.lsp.enable({
        "vtsls", "eslint", "jsonls", "html", "cssls", "tailwindcss", "astro", "svelte",
        "lua_ls", "basedpyright", "ruff", "rust_analyzer",
      })
    end,
  },
}
