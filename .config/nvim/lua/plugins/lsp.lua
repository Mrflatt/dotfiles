return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "j-hui/fidget.nvim", opts = {} },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local default_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      local servers = {
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
        yamlls = {},
        gopls = {
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              staticcheck = true,
              analyses = {
                unusedparams = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                functionTypeParameters = false,
                constantValues = true,
                parameterNames = true,
                rangeVariableTypes = false,
              },
            },
          },
        },
      }

      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        ensure_installed = {
          "lua-language-server",
          "prettierd",
          "stylua",

          "gopls",
          "shfmt",
          "goimports",
          "golines",
          "gomodifytags",
          "yamlls",
          "yamlfmt",
          "xmlformatter",
        },
      })

      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      local lspconfig = require("lspconfig")
      local on_attach = require("configs.lsp").on_attach
      local capabilities = require("configs.lsp").capabilities
      require("mason-lspconfig").setup({
        handlers = {
          function(name)
            local config = servers[name] or {}
            lspconfig[name].setup({
              capabilities = capabilities,
              filetypes = config.filetypes,
              handlers = vim.tbl_deep_extend("force", default_handlers, config.handlers or {}),
              on_attach = on_attach,
              settings = config.settings,
            })
          end,
        },
      })

      -- Configure borderd for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Configure diagnostics border
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end,
  },
}
