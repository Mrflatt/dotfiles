return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "letieu/harpoon-lualine" },
    lazy = false,
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = false,
        },
      })

      local opts = { noremap = true, silent = true }
      -- Open harpoon ui
      vim.keymap.set("n", "<leader>ho", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, opts)
      -- Add current file to harpoon
      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():append()
      end, opts)
      -- Remove current file from harpoon
      vim.keymap.set("n", "<leader>hr", function()
        harpoon:list():remove()
      end, opts)
      -- Remove all files from harpoon
      vim.keymap.set("n", "<leader>hc", function()
        harpoon:list():clear()
      end, opts)
      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end, opts)
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end, opts)
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end, opts)
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end, opts)
      vim.keymap.set("n", "<leader>5", function()
        harpoon:list():select(5)
      end, opts)
    end,
  },
}
