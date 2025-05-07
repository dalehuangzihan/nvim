return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls", "pyright", "ltex", "texlab" },
      })
    end,
  },
  -- {
  --   'b0o/schemastore.nvim',
  -- },
  -- {
  --   "nvim-java/nvim-java",
  -- },
  {
    "cmp-nvim-lsp",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      local opts = {}
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.lemminx.setup({
        capabilities = capabilities,
      })

      lspconfig.marksman.setup({
        capabilities = capabilities,
      })

      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
      })

      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
        --init_options = {
        --    fallbackFlags = { '-std=c++20', '-I/usr/include/c++/13' },
        --},
      })

      -- lspconfig.yamlls.setup {
      --   capabilities = capabilities,
      --   settings = {
      --     yaml = {
      --       schemaStore = {
      --         -- You must disable built-in schemaStore support if you want to use
      --         -- this plugin and its advanced options like `ignore`.
      --         enable = false,
      --         -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      --         url = '',
      --       },
      --       schemas = require('schemastore').yaml.schemas(),
      --     },
      --   },
      -- }

      lspconfig.gopls.setup({
        root_dir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
          },
        },
      })

      lspconfig.hls.setup({
        --filetypes = { 'haskell', 'lhaskell', 'cabal' },
      })

      -- require("java").setup()

      lspconfig.jdtls.setup({
        capabilities = capabilities,
      })

      lspconfig.gradle_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.ltex.setup({
        capabilities = capabilities,
        settings = {
          ltex = {
            language = "en-GB",
          },
        },
      })

      lspconfig.texlab.setup({})

      -- vim.keymap.set("n", "k", vim.lsp.buf.hover, {})
      -- vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
      -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      -- vim.keymap.set("n", "k", vim.lsp.buf.hover, opts)
      -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      -- vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, opts)
      -- vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, opts)
      -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      -- vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
      -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      -- vim.keymap.set("n", "<space>f", function()
      --   vim.lsp.buf.format({ async = true })
      -- end, opts)
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
  },
}
