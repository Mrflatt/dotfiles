return {
  {
    "j-hui/fidget.nvim",
    tag = "v1.5.0",
    event = { "BufEnter" },
    config = function()
      -- Turn on LSP, formatting, and linting status and progress information
      require("fidget").setup({
        text = {
          spinner = "dots_negative",
        },
      })
    end,
  },
}
