vim.keymap.set(
  "n",
  "<leader>mp",
  "<cmd>MarkdownPreviewToggle<CR>",
  { desc = "Toggle markdown preview", noremap = true, silent = true }
)

return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  cmd = {
    "MarkdownPreviewToggle",
    "MarkdownPreview",
    "MarkdownPreviewStop",
  },
}
