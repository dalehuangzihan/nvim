local lsp = require('lsp-zero')

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<CR>'] = cmp.mapping.confirm({ select = true });
	['<C-Space>'] = cmp.mapping.complete(),
})

-- lsp.set_preferences({
--	sign_icons = {}
-- })

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	--  lsp.default_keymaps({
		--	  buffer = bufnr,
		--	  preserve_mappings = false,
	--  })
	
	local opts = {buffer = bufnr, remap = false}
	-- these will be buffer-local keybindings
	-- because they only work if you have an active language server
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set({'n', 'x'}, 'gF', function() vim.lsp.buf.format({async = true}) end, opts)
	vim.keymap.set('n', 'gC', function() vim.lsp.buf.code_action() end, opts)

    -- -- TODO: is broken... needs fix
    -- -- fancy rename (https://blog.viktomas.com/graph/neovim-lsp-rename-normal-mode-keymaps/)
    -- vim.keymap.set("n", "<leader>r", function()
    --     -- when rename opens the prompt, this autocommand will trigger
    --     -- it will "press" CTRL-F to enter the command-line window `:h cmdwin`
    --     -- in this window I can use normal mode keybindings
    --     local cmdId
    --     cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    --         callback = function()
    --             local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
    --             vim.api.nvim_feedkeys(key, "c", false)
    --             vim.api.nvim_feedkeys("0", "n", false)
    --             -- autocmd was triggered and so we can remove the ID and return true to delete the autocmd
    --             cmdId = nil
    --             return true
    --         end,
    --     })
    --     vim.lsp.buf.rename()
    --     -- if LPS couldn't trigger rename on the symbol, clear the autocmd
    --     vim.defer_fn(function()
    --         -- the cmdId is not nil only if the LSP failed to rename
    --         if cmdId then
    --             vim.api.nvim_del_autocmd(cmdId)
    --         end
    --     end, 500)
    -- end, bufoptsWithDesc("Rename symbol"))

end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {
	'clangd',
	'cmake',
	'jsonls',
	'jdtls',
	'ltex',
	'marksman',
	'pylsp',
	'lemminx',
	'yamlls',
  },
  handlers = {
    lsp.default_setup,
  }
})


lsp.setup()
