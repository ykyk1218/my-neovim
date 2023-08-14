local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-e>", "<Esc>$a", opts)
keymap("n", "<C-a>", "<Esc>^i", opts)

-- fzf-lua
keymap("c", "fff", "FzfLua grep", opts)
keymap("c", "ffg", "FzfLua git_files", opts)
keymap("c", "ffo", "FzfLua oldfiles", opts)
keymap("c", "ffl", "FzfLua", opts)
keymap("c", "FFF", "FZF", opts)

-- tab
keymap("n", ")", "gt", opts)
keymap("n", "(", "gT", opts)

-- vim-fugitive
keymap("n", ",gh", "vl:GBrowse", opts)
keymap("v", ",gh", ":GBrowse", opts)

-- fern
keymap("n", "<C-n>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>", opts)

-- remove and append keyword
keymap("c", "___" , ":set iskeyword-=_", opts)
keymap("c", "__", ":set iskeyword+=_", opts)


vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
