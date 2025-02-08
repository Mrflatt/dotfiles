return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = {
            enabled = true,
            scope_color = "sapphire",
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          notify = true,
          nvimtree = true,
          neotree = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          rainbow_delimiters = true,
        },
      })
      -- latte, frappe, macchiato, mocha
      vim.cmd.colorscheme("catppuccin-mocha")

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
}
