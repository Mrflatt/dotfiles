vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

return {
  {
    "stevearc/oil.nvim",
    opts = {},
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      oil.setup({
        use_default_keymaps = false,
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        buf_options = {
          buflisted = true,
          bufhidden = "hide",
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-h>"] = "actions.select_split",
          ["<C-s>"] = "actions.select_vsplit", -- this is used to navigate left
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["<C-T>"] = "actions.open_terminal",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set("n", "<leader>e", function()
        oil.toggle_float()
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>E", function()
        oil.open()
      end, { noremap = true, silent = true })
    end,
  },
}
