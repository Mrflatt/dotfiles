return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertLeave" },
  config = function()
    local conform = require("conform")
    conform.setup({
      notify_on_error = true,
      formatters = {
        yamlfmt = {
          prepend_args = { "-formatter", "indent=2,include_document_start=true" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        golines = {
          prepend_args = { "--max-len", "120" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        kotlin = { "ktlint" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        go = { "golines" },
        rust = { "rustfmt" },
        yaml = { { "prettierd", "yamlfmt" } },
        bash = { "shfmt" },
        sh = { "shfmt" },
        json = { "jq" },
      },
      format_on_save = {
        async = false,
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>l", function()
      conform.format({
        async = true,
        lsp_fallback = true,
        timeout_ms = 1000,
      })
    end, { desc = "Format the current buffer", noremap = true, silent = true })
  end,
}
