vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Disable text wrap
vim.opt.wrap = false

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 200
vim.opt.inccommand = "split"
-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menuone", "noselect" }

-- Enable persistent undo history
vim.opt.undofile = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Enable access to System Clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.scrolloff = 10
vim.opt.colorcolumn = "120"
