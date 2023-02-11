return {
    -- Snipet engine
    'L3MON4D3/LuaSnip',

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            -- Completion sources
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-c>'] = cmp.mapping.abort(),
                    ['<C-j>'] = cmp.mapping.confirm { select = true },
                    -- ['<C-j>'] = cmp.mapping(function ()
                    --     if luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         cmp.confirm{ select = true }
                    --     end
                    -- end),
                    ['<C-i>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable( -1) then
                            luasnip.jump( -1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-m>'] = cmp.mapping.scroll_docs(4),
                    ['<C-o>'] = cmp.mapping.scroll_docs( -4),
                },
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

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = {
                    ['<Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            else
                                fallback()
                            end
                        end
                    },
                    ['<S-Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            else
                                fallback()
                            end
                        end
                    },
                },
                sources = {
                    { name = 'buffer' }
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = {
                    ['<Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            else
                                fallback()
                            end
                        end
                    },
                    ['<S-Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            else
                                fallback()
                            end
                        end
                    },
                },
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },


    -- Add/delete/replace surroundings such as (), "".
    {
        'machakann/vim-sandwich',
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
        end,
        keys = {
            { mode = 'n',          'ds',  '<Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)' },
            { mode = 'n',          'dsb', '<Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-auto-a)' },
            { mode = 'n',          'cs',  '<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)' },
            { mode = 'n',          'csb', '<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-auto-a)' },
            { mode = 'n',          'ys',  '<Plug>(operator-sandwich-add)' },
            { mode = 'n',          'yss', '<Plug>(operator-sandwich-add)_' },
            { mode = 'v',          'S',   '<Plug>(operator-sandwich-add)' },
            { mode = { 'x', 'o' }, 'ib',  '<Plug>(textobj-sandwich-auto-i)' },
            { mode = { 'x', 'o' }, 'ab',  '<Plug>(textobj-sandwich-auto-a)' },
        },
        config = function()
            vim.fn['operator#sandwich#set']('all', 'all', 'hi_duration', 100)
        end,
    },

    -- Automatically close surroundings
    {
        "windwp/nvim-autopairs",
        config = true,
    },

    -- Toggle comments
    {
        'numToStr/Comment.nvim',
        config = true,
    },
}
