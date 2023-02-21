vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Colorschemes
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    -- Telesccope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- Others
    use 'tpope/vim-fugitive'
    use 'theprimeagen/harpoon'
    use 'nvim-tree/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'

    use {
        "folke/trouble.nvim",
        config = function() require("trouble").setup { icons = false, } end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup {} end
    }

    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup {} end
    }

    use {
        'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        'windwp/nvim-ts-autotag',
        config = function() require("nvim-ts-autotag").setup {} end
    }

    use {
        'kylechui/nvim-surround',
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function() require("nvim-surround").setup {} end
    }
end)
