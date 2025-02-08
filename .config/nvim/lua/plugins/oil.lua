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
        skip_confirm_for_simple_edits = true,
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
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
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
          ["gd"] = {
            desc = "Toggle detail view",
            callback = function()
              local config = require("oil.config")
              if #config.columns == 1 then
                oil.set_columns({ "icon", "permissions", "size", "mtime" })
              else
                oil.set_columns({ "icon" })
              end
            end,
          },
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            return name == ".."
          end,
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
