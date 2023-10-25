return {
    { "nvim-tree/nvim-web-devicons", lazy = true },

    { "windwp/nvim-autopairs", enabled = false, opts = {} },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        version = "*",
        opts = {}
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        enabled = true,
        opts = {
            view = {
                adaptive_size = true,
            },
        },
        keys = {
            { "<leader>vn", vim.cmd.NvimTreeToggle },
        }
    },

    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },

    -- so upset with .erb file
    {
        "alvan/vim-closetag",
        event = "BufRead",
        setup = function()
            vim.g.closetag_emptyTags_caseSensitive = 1
            -- Some other settings
        end,
    },
}

