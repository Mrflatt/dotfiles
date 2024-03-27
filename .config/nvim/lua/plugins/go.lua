return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  config = function()
    require("go").setup({
      tag_transform = "camelcase",
      tag_options = false,
    })
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>gsj", "<cmd>GoModifyTag -add-tags json<CR>", opts)
    vim.keymap.set("n", "<leader>gsy", "<cmd>GoModifyTag -add-tags yaml<CR>", opts)
    vim.keymap.set("n", "<leader>gsx", "<cmd>GoModifyTag -add-tags xml<CR>", opts)
    vim.keymap.set("n", "<leader>gst", "<cmd>GoModifyTag -add-tags toml<CR>", opts)
    vim.keymap.set("n", "<leader>gsc", "<cmd>GoClearTag<CR>", opts)
  end,
  ft = { "go", "gomod", "gowork", "gotmpl" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
