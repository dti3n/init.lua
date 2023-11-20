return {
    { "nvim-tree/nvim-web-devicons", enabled = true, lazy = true },

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
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        enabled = false,
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
                signcolumn = 'no',
                number = true,
                relativenumber = true,
            },
        },
        keys = {
            { "<leader>vn", vim.cmd.NvimTreeToggle },
        }
    },

}

