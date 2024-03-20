local opts = { noremap = true, silent = true }
-- Disable Space bar since it'll be used as the leader key
vim.keymap.set("n", "<space>", "<nop>", opts)
vim.keymap.set("n", "<left>", '<cmd>echo "Press h"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Press l"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Press k"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Press j"<CR>')
-- Swap between last two buffers
vim.keymap.set("n", "<leader>'", "<C-^>", { desc = "Switch to last buffer", noremap = true, silent = true })
-- Save with leader key
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false, noremap = true })
-- Quit with leader key
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false, noremap = true })
-- Save and Quit with leader key
vim.keymap.set("n", "<leader>z", "<cmd>wq<cr>", { silent = false, noremap = true })
-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "{", "{zz", opts)
vim.keymap.set("n", "}", "}zz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "G", "Gzz", opts)
vim.keymap.set("n", "gg", "ggzz", opts)
vim.keymap.set("n", "<C-i>", "<C-i>zz", opts)
vim.keymap.set("n", "<C-o>", "<C-o>zz", opts)
vim.keymap.set("n", "%", "%zz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n", "S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, opts)
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", opts)
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "<tab>", "gt", opts)
vim.keymap.set("n", "<S-tab>", "gT", opts)
-- Press 'U' for redo
vim.keymap.set("n", "U", "<C-r>", opts)
-- Turn off highlighted results
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Goto next diagnostic of any severity
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, opts)
-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, opts)
-- Goto next error diagnostic
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, opts)
-- Goto previous error diagnostic
vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, opts)
-- Goto next warning diagnostic
vim.keymap.set("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, opts)
-- Goto previous warning diagnostic
vim.keymap.set("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, opts)
-- Open the diagnostic under the cursor in a float window
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float({
    border = "rounded",
  })
end, opts)
-- Place all dignostics into a qflist
vim.keymap.set(
  "n",
  "<leader>ld",
  vim.diagnostic.setqflist,
  vim.list_extend(opts, { desc = "Quickfix [L]ist [D]iagnostics" })
)
-- Navigate to next qflist item
vim.keymap.set("n", "<leader>cn", ":cnext<cr>zz", opts)
-- Navigate to previos qflist item
vim.keymap.set("n", "<leader>cp", ":cprevious<cr>zz", opts)
-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<cr>zz", opts)
-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<cr>zz", opts)
-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=", opts)
-- Press leader rw to rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows", noremap = true })
-- Press gx to open the link under the cursor
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>", opts)
-- Git keymaps --
vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>")
-- Map jj to <esc>
vim.keymap.set("i", "jj", "<esc>", opts)
-- Visual --
-- Disable Space bar since it'll be used as the leader key
vim.keymap.set("v", "<space>", "<nop>", opts)
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("v", "L", "$<left>", opts)
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
-- Paste without losing the contents of the register
vim.keymap.set("x", "<leader>p", '"_dP', opts)
-- Reselect the last visual selection
vim.keymap.set("x", "<<", function()
  -- Move selected text up/down in visual mode
  vim.cmd("normal! <<")
  vim.cmd("normal! gv")
end, opts)
vim.keymap.set("x", ">>", function()
  vim.cmd("normal! >>")
  vim.cmd("normal! gv")
end, opts)
-- Terminal --
-- Enter normal mode while in a terminal
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)
-- Window navigation from terminal
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
-- Reenable default <space> functionality to prevent input delay
vim.keymap.set("t", "<space>", "<space>", opts)
