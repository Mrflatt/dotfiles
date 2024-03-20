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

      local builtin = require("telescope.builtin")
      local opts = { noremap = true, silent = true }
      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(_client, bufnr)
        opts.buffer = bufnr

        opts.desc = "LSP: [R]e[n]ame"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "LSP: [C]ode [A]ction"
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "LSP: [G]oto [D]efinition"
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- telescope lsp keymaps
        opts.desc = "LSP: [G]oto [R]eferences"
        vim.keymap.set("n", "gr", builtin.lsp_references, opts)

        opts.desc = "LSP: [G]oto [I]mplementation"
        vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)

        opts.desc = "LSP: [B]uffer [S]ymbols"
        vim.keymap.set("n", "<leader>bs", builtin.lsp_document_symbols, opts)

        opts.desc = "LSP: [P]roject [S]ymbols"
        vim.keymap.set("n", "<leader>ps", builtin.lsp_workspace_symbols, opts)

        opts.desc = "LSP: Hover Documentation"
        -- See `:help K` for why this keymap
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "LSP: Signature Documentation"
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

        opts.desc = "LSP: [G]oto [D]eclaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "LSP: [T]ype [D]efinition"
        vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        bashls = {},
        eslint = {},
        html = {},
        jsonls = {},
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
        marksman = {},
        pyright = {},
        tsserver = {
          settings = {
            maxTsServerMemory = 12000,
          },
        },
        yamlls = {},
        gopls = {
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        kotlin_language_server = {},
      }

      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        ensure_installed = {
          "lua-language-server",
          "html-lsp",
          "prettier",
          "prettierd",
          "stylua",

          "typescript-language-server",
          "gopls",
          "shfmt",
          "goimports",
          "golines",
          "gofumpt",
          "gomodifytags",
          "yamlls",
          "rust-analyzer",
          "kotlin-language-server",
          "yamlfmt",
        },
      })

      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      local lspconfig = require("lspconfig")
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
