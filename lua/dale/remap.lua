vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- # Restarting LSP server # --
vim.keymap.set("n", "<leader><Tab>", function()
    -- turn off lsp server
    vim.lsp.stop_client(vim.lsp.get_clients())
end)
vim.keymap.set("n", "<leader><Tab><Tab>", function()
    -- turn lsp server back on
    vim.cmd.write()
    vim.cmd.edit()
end)
-- vim.keymap.set("n", "<leader><Tab>", "<Cmd>LspRestart<CR>")
