vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Restart LSP
vim.keymap.set("n", "<leader><Tab>", "<Cmd>wa<CR> <bar> <Cmd>lua vim.lsp.stop_client(vim.lsp.get_clients())<CR> <bar> <Cmd>edit<CR>")

