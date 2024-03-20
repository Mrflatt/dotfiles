local is_git_directory = function()
  local result = vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 and result:find("true") then
    return true
  else
    return false
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = vim.fn.executable("cmake") == 1,
      },
    },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")
      local themes = require("telescope.themes")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-x>"] = actions.delete_buffer,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            ".git",
            ".sl",
            "_build",
            ".next",
            "build",
            "target",
          },
          hidden = true,
        },
      })

      local opts = { noremap = true, silent = true }
      -- Telescope keybinds --
      vim.keymap.set(
        "n",
        "<leader>?",
        builtin.oldfiles,
        vim.list_extend(opts, { desc = "[?] Find recently opened files" })
      )
      vim.keymap.set("n", "<leader>fb", builtin.buffers, vim.list_extend(opts, { desc = "[S]ind Open [B]uffers" }))
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = true })
      end, vim.list_extend(opts, { desc = "[F]ind [F]iles" }))
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, vim.list_extend(opts, { desc = "[F]ind [H]elp" }))
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, vim.list_extend(opts, { desc = "[F]ind by [G]rep" }))
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, vim.list_extend(opts, { desc = "[F]ind current [W]ord" }))
      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown({
          previewer = false,
        }))
      end, vim.list_extend(opts, { desc = "[/] Fuzzily search in current buffer]" }))
      vim.keymap.set("n", "<leader>fs", function()
        builtin.spell_suggest(themes.get_dropdown({
          previewer = false,
        }))
      end, vim.list_extend(opts, { desc = "[F]ind [S]pelling suggestions" }))
      vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
          hidden = true,
          no_ignore = true,
        })
      end, vim.list_extend(opts, { desc = "[F]ind [N]eovim files" }))
      vim.keymap.set("n", "<leader>gf", function()
        local cmd = {
          "sort",
          "-u",
          "<(git diff --name-only --cached)",
          "<(git diff --name-only)",
          "<(git diff --name-only --diff-filter=U)",
        }

        if not is_git_directory() then
          vim.notify(
            "Current project is not a git directory",
            vim.log.levels.WARN,
            { title = "Telescope Git Files", git_command = cmd }
          )
        else
          builtin.git_files()
        end
      end, vim.list_extend(opts, { desc = "Find [G]it [F]iles" }))

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
