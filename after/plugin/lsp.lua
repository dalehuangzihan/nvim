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
	vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
	vim.keymap.set('n', '<F4>', function() vim.lsp.buf.code_action() end, opts)

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
