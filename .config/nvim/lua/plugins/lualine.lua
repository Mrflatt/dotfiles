return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local harpoon = {
        "harpoon2",
        icon = "󰀱 ",
        indicators = { "1", "2", "3", "4", "5" },
        active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]" },
        separator = " ",
      }

      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "█", right = "█" },
        },
        sections = {
          lualine_b = {
            harpoon,
            "branch",
            "diff",
            "diagnostics",
          },
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            "filetype",
          },
        },
      })
    end,
  },
}
