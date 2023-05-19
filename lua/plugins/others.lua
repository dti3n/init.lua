return {
    'nvim-tree/nvim-web-devicons',

    { 'numToStr/Comment.nvim', opts = {} },
    { 'windwp/nvim-autopairs', opts = {} },
    { 'windwp/nvim-ts-autotag', opts = {}, enabled = false },

    {
        'tpope/vim-fugitive',
        keys = {
            { "<leader>gs", vim.cmd.Git },
            { "gh", "<cmd>diffget //2<CR>"},
            { "gl", "<cmd>diffget //2<CR>"},
        }
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
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
}

