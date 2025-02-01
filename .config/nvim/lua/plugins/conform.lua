return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertLeave" },
  config = function()
    local conform = require("conform")
    conform.setup({
      notify_on_error = true,
      notify_no_formatters = true,
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
        xmlformat = {
          prepend_args = { "--selfclose", "--indent", "4" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        kotlin = { "ktlint" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofumpt" },
        rust = { "rustfmt" },
        yaml = { "prettierd", "yamlfmt", stop_after_first = true },
        bash = { "shfmt" },
        sh = { "shfmt" },
        json = { "jq" },
        xml = { "xmlformat" },
        -- ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        async = false,
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>l", function()
      conform.format({
        async = true,
        lsp_format = "fallback",
        timeout_ms = 1000,
      })
    end, { desc = "Format the current buffer", noremap = true, silent = true })
  end,
}
