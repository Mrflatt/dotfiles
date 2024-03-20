return {
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "catppuccin/nvim",
    },
    config = function()
      local theme = require("catppuccin.palettes").get_palette("macchiato")
      local spectre = require("spectre")

      vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.base })
      vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.base })

      spectre.setup({
        highlight = {
          search = "SpectreSearch",
          replace = "SpectreReplace",
        },
        mapping = {
          ["send_to_qf"] = {
            map = "<C-q>",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix",
          },
        },
      })
      -- Open Spectre for global find/replace
      vim.keymap.set("n", "<leader>S", function()
        spectre.toggle()
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>sw", function()
        spectre.open_visual({ select_word = true })
      end, { desc = "Search current word", noremap = true, silent = true })
    end,
  },
}
