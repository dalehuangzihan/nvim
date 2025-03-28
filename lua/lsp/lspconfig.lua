---------------------------------------
-- # Configure Custom Key Mappings # --
---------------------------------------

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- # Custom Mappings # --
        local opts = { buffer = bufnr, remap = false }
        -- These will be buffer-local keybindings because
        -- they only work if you have an active language server

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars

            -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Format upon manual keybind invocation.
        if client:supports_method('textDocument/formatting') then
            vim.keymap.set({ 'n', 'x' }, 'gF', function() vim.lsp.buf.format({ async = true }) end, opts)
        end
        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        -- if not client:supports_method('textDocument/willSaveWaitUntil')
        --     and client:supports_method('textDocument/formatting') then
        --     vim.api.nvim_create_autocmd('BufWritePre', {
        --         group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        --         buffer = args.buf,
        --         callback = function()
        --             vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        --         end,
        --     })
        -- end

        if client:supports_method('textDocument/hover') then
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        end
        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        end
        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
        end
        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
        end
        if client:supports_method('textDocument/typeDefinition*') then
            vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
        end
        if client:supports_method('textDocument/references') then
            vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
        end
        if client:supports_method('textDocument/signatureHelp') then
            vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
        end
        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end, opts)
        end
        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', 'gC', function() vim.lsp.buf.code_action() end, opts)
        end
        if client:supports_method('textDocument/diagnostic') then
            -- TODO: check if this conditional works.
            vim.keymap.set( "n", "gl", function() vim.diagnostic.open_float() end, opts)
        end

    end,
})

----------------------------------------------------
-- # Set up LSP Code Suggestions & Autocomplete # --
----------------------------------------------------

-- Set up nvim-cmp.
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
})
require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up nvim-lspconfig. -- Dale: it's just getting a set of default capabilities
local cmp_nvim_lsp_config_defaults = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--     capabilities = capabilities
-- }

----------------------
-- # Set up Mason # --
----------------------

require('mason').setup({})
require('mason-lspconfig').setup({
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
})

------------------------------------------
-- # Language-Specific Configurations # --
------------------------------------------

vim.lsp.config('*', {
    capabilities = cmp_nvim_lsp_config_defaults,
    -- capabilities = {
    --     textDocument = {
    --         semanticTokens = {
    --             multilineTokenSupport = true,
    --         }
    --     }
    -- },
    root_markers = { '.git' },
})

vim.lsp.config['luals'] = {
    -- Command and arguments to start the server.
    cmd = { 'lua-language-server' },
    -- Filetypes to automatically attach to.
    filetypes = { 'lua' },
    -- Sets the "root directory" to the parent directory of the file in the
    -- current buffer that contains either a ".luarc.json" or a
    -- ".luarc.jsonc" file. Files that share a root directory will reuse
    -- the connection to the same LSP server.
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    -- Specific settings to send to the server. The schema for this is
    -- defined by the server. For example the schema for lua-language-server
    -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
}
vim.lsp.enable('luals')

vim.lsp.config['pythonls'] = {
    cmd = { 'python-lsp-server' },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
vim.lsp.enable('pythonls')

vim.lsp.config.clangd = {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--background-index',
        '--offset-encoding=utf-8',
    },
    root_markers = { '.clangd', 'compile_commands.json' },
    filetypes = { 'c', 'cpp' },
}
vim.lsp.enable('clangd')
