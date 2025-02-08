local M = {}
M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP: [R]e[n]ame"))
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("LSP: [C]ode [A]ction"))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("LSP: [G]oto [D]efinition"))
  -- telescope lsp keymaps
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "gr", builtin.lsp_references, opts("LSP: [G]oto [R]eferences"))
  vim.keymap.set("n", "gi", builtin.lsp_implementations, opts("LSP: [G]oto [I]mplementation"))
  vim.keymap.set("n", "<leader>bs", builtin.lsp_document_symbols, opts("LSP: [B]uffer [S]ymbols"))
  vim.keymap.set("n", "<leader>ps", builtin.lsp_workspace_symbols, opts("LSP: [P]roject [S]ymbols"))
  -- See `:help K` for why this keymap
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP: Hover Documentation"))
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts("LSP: Signature Documentation"))
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("LSP: Signature Help"))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("LSP: [G]oto [D]eclaration"))
  vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts("LSP: [T]ype [D]efinition"))
  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set("n", "<space>h", function()
      local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr })
      vim.lsp.inlay_hint.enable(not current_setting, { bufnr })
    end, opts("LSP: Toggle inlay hints"))
  end
  -- vim.lsp.inlay_hint.enable(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
return M
