return {
  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    enabled = false,
    config = function()
      --- @diagnostic disable: unused-local
      local ufo = require("ufo")
      ufo.setup({
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      })
      -- nvim-ufo keybinds
      vim.keymap.set("n", "zR", ufo.openAllFolds)
      vim.keymap.set("n", "zM", ufo.closeAllFolds)
    end,
  },
}
