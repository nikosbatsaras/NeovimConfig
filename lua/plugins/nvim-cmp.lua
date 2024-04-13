return {
        "hrsh7th/nvim-cmp",
        dependencies = {
                'neovim/nvim-lspconfig',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                -- Snippets
                'hrsh7th/cmp-vsnip',
                'hrsh7th/vim-vsnip',
        },
        config = function()
                local cmp = require 'cmp'

                cmp.setup({
                        snippet = {
                                -- REQUIRED - you must specify a snippet engine
                                expand = function(args)
                                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                                end,
                        },
                        window = {
                                -- completion = cmp.config.window.bordered(),
                                -- documentation = cmp.config.window.bordered(),
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
                                { name = 'vsnip' }, -- For vsnip users.
                        }, {
                                { name = 'buffer' },
                        })
                })

                -- Set configuration for specific filetype.
                cmp.setup.filetype('gitcommit', {
                        sources = cmp.config.sources({
                                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                        }, {
                                { name = 'buffer' },
                        })
                })

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

                local lspconfig = require('lspconfig')
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                lspconfig['gopls'].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        cmd = { "gopls" },
                        filetypes = { "go", "gomod", "gowork", "gotmpl" },
                        root_dir = vim.loop.cwd,
                        settings = {
                                gopls = {
                                        completeUnimported = true,
                                        usePlaceholders = true,
                                        analyses = {
                                                unusedparams = true,
                                        },
                                },
                        },
                }
                lspconfig["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                                Lua = {
                                        -- make the language server recognize "vim" global
                                        diagnostics = {
                                                globals = { "vim" },
                                        },
                                        completion = {
                                                callSnippet = "Replace",
                                        },
                                },
                        },
                })
        end,
}
