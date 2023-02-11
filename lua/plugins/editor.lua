local function ts_builtin(func_name)
    return function()
        require('telescope.builtin')[func_name]()
    end
end

return {
    -- Show indent vertical line
    "lukas-reineke/indent-blankline.nvim",

    -- Show initial line of function, etc.
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        event = "BufReadPost",
    },

    -- Show code outline
    {
        'simrat39/symbols-outline.nvim',
        cmd = {
            'SymbolsOutline',
            'SymbolsOutlineOpen',
            'SymbolsOutlineClose',
        },
        config = function()
            require("symbols-outline").setup()
        end
    },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        keys = {
            { '<Leader>ft',      '<Cmd>Telescope<CR>' },
            { '<Leader>ff',      ts_builtin('find_files') },
            { '<Leader><space>', ts_builtin('find_files') },
            { '<Leader>fo',      ts_builtin('oldfiles') },
            { '<Leader>fh',      ts_builtin('help_tags') },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    layout_config = {
                        preview_width = 0.6,
                    },
                    mappings = {
                        i = {
                            ['<Esc>'] = require('telescope.actions').close,
                            ['<C-u>'] = false,
                            ["<C-d>"] = false
                        },
                    },
                },
            }
        end,
    },
}
