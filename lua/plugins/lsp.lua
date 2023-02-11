return {
    -- Lsp server manager
    {
        'williamboman/mason.nvim',
        cmd = "Mason",
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = true,
    },

    -- Configs for the LSP client
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<Leader>dk', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<Leader>ac', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                -- vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                -- vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                -- vim.keymap.set('n', '<Leader>wl', function()
                --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                -- end, bufopts)
                -- vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
            end

            local lsp_flags = {
                -- This is the default in Nvim 0.7+
                debounce_text_changes = 150,
            }

            require('lspconfig')['sumneko_lua'].setup {
                on_attach = on_attach,
                flags = lsp_flags,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
            require('lspconfig')['rust_analyzer'].setup {
                on_attach = on_attach,
                flags = lsp_flags,
                capabilities = capabilities,
                -- Server-specific settings...
                settings = {
                    ['rust-analyzer'] = {},
                }
            }
        end,
    },

    -- Show inlay hints
    {
        'lvimuser/lsp-inlayhints.nvim',
        config = function()
            require('lsp-inlayhints').setup()
            vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
            vim.api.nvim_create_autocmd('LspAttach', {
                group = 'LspAttach_inlayhints',
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require('lsp-inlayhints').on_attach(client, bufnr, false)
                    vim.api.nvim_set_hl(0, 'LspInlayHint', { italic = true, fg = '#83a598', bg = '#3c3836' })
                end,
            })
        end
    },

    -- Show lsp progress at the right bottom corner
    {
        'j-hui/fidget.nvim',
        config = function()
            require("fidget").setup()
        end
    }
}
