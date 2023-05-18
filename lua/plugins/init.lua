return {
    'tpope/vim-fugitive',
    'numToStr/Comment.nvim',
    'ThePrimeagen/harpoon',

    {
        'rose-pine/neovim',
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                disable_italics = true,
                disable_background = true,
                disable_float_background = false,
            })
            vim.cmd.colorscheme 'rose-pine'
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'rose-pine',
                component_separators = '',
                section_separators = '',
            },
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
    },

    {
        -- LSP
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup({})
        end
    },

    {
        'windwp/nvim-ts-autotag',
        config = function()
            require("nvim-ts-autotag").setup({})
        end
    },
}

