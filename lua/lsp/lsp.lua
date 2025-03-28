vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    root_markers = { '.git' },
})

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

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
        -- Format upon manual keybind invocation.
        -- if client:supports_method('textDocument/formatting') then
        --     vim.keymap.set({ 'n', 'x' }, 'gF', function() vim.lsp.buf.format({ async = true }) end, opts)
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

    end,
})

-- # Set up Mason # --
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

-- # Language-Specific Configurations # --

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

