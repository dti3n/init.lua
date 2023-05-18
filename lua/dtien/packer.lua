vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Colorschemes
    use({
        'rose-pine/neovim', as = 'rose-pine',
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
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    use('nvim-treesitter/nvim-treesitter-context')

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }

    -- Others
    use 'tpope/vim-fugitive'
    use 'theprimeagen/harpoon'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'

    use {
        "folke/trouble.nvim",
        config = function() require("trouble").setup {} end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
        }
        end
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
