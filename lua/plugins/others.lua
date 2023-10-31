return {
    { "nvim-tree/nvim-web-devicons", enabled = false, lazy = true },

    { "windwp/nvim-autopairs", enabled = false, opts = {} },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        version = "*",
        config = function()
            require("nvim-surround").setup ({
                 surrounds = {
                    ["e"] = {
                        add = function()
                            return { { "<% " }, { " %>" } }
                        end,
                    }
                }
            })

            -- vim.keymap.set({ "n", "v" }, "<leader>ye", "g@iwe")
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        enabled = true,
        opts = {
            renderer = {
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = true,
                        git = true,
                    }
                }
            },
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
        enabled = false,
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

    {
        "tpope/vim-rails",
        lazy = false,
        keys = {
            { "<leader>rc", vim.cmd.Econtroller },
            { "<leader>rv", vim.cmd.Eview },
            { "<leader>rm", vim.cmd.Emodel },
        }
    },

}

