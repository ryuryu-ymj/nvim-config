return {
    -- Show indent vertical line
    "lukas-reineke/indent-blankline.nvim",

    --
    'nvim-treesitter/nvim-treesitter-context',

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
        config = function()
            local builtin = require('telescope.builtin')
            local actions = require('telescope.actions')

            vim.keymap.set('n', '<Leader>ft', '<Cmd>Telescope<CR>')
            vim.keymap.set('n', '<Leader>ff', builtin.find_files)
            vim.keymap.set('n', '<Leader><space>', builtin.find_files)
            vim.keymap.set('n', '<Leader>fo', builtin.oldfiles)
            vim.keymap.set('n', '<Leader>fh', builtin.help_tags)

            require('telescope').setup {
                defaults = {
                    layout_config = {
                        preview_width = 0.6,
                    },
                    mappings = {
                        i = {
                            ['<Esc>'] = actions.close,
                            ['<C-u>'] = false,
                            ["<C-d>"] = false
                        },
                    },
                },
            }
        end,
    },
}
