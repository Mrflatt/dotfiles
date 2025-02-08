vim.keymap.set("n", "<leader>s", function()
  require("spectre").toggle({ is_insert_mode = true })
end, { desc = "Toggle Spectre", noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word", noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>sp", function()
  require("spectre").open_file_search({ select_word = true })
end, { desc = "Search current word in file", noremap = true, silent = true })

return {
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "catppuccin/nvim",
    },
    config = function()
      local theme = require("catppuccin.palettes").get_palette("mocha")

      vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.base })
      vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.base })

      require("spectre").setup({
        highlight = {
          search = "SpectreSearch",
          replace = "SpectreReplace",
        },
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = { "-i", "", "-E" },
          },
        },
        mapping = {
          ["send_to_qf"] = {
            map = "<C-q>",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix",
          },
        },
      })
    end,
  },
}
