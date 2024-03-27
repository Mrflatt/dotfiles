return {
  "mrcjkb/rustaceanvim",
  version = "^4", -- Recommended
  ft = { "rust" },
  opts = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  config = function()
    local on_attach = require("configs.lsp").on_attach
    local capabilities = require("configs.lsp").capabilities
    vim.g.rustaceanvim = {
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
      },
    }
  end,
}
