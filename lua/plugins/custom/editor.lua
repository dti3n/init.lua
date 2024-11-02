return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" },
        },
    },

    {
        "tpope/vim-sleuth",
        cmd = { "Sleuth" },
    },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    {
        "folke/trouble.nvim",
        opts = {},
        keys = {
            {
                "<leader>xl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                aliases = { ["b"] = "`" },
                surrounds = {
                    ["b"] = {
                        add = function()
                            return { { "`" }, { "`" } }
                        end,
                    },
                    ["c"] = {
                        add = function()
                            return { { "{/* " }, { " */}" } }
                        end,
                    },
                },
            })
            local v_chars = { "(", ")", "[", "]", "{", "}", "'", '"', "`" }
            for _, char in pairs(v_chars) do
                vim.keymap.set(
                    "v",
                    char,
                    "<Plug>(nvim-surround-visual)" .. char
                )
            end
        end,
    },

    {
        "Wansmer/treesj",
        cmd = { "TreeToggle", "TreeSplit", "TreeJoin" },
        config = function()
            require("treesj").setup({ use_default_keymaps = false })

            local usercmd = vim.api.nvim_create_user_command

            usercmd("TreeToggle", function()
                require("treesj").toggle({ split = { recursive = true } })
            end, {})

            usercmd("TreeSplit", function()
                require("treesj").split({ split = { recursive = true } })
            end, {})

            usercmd("TreeJoin", function()
                require("treesj").join({ join = { recursive = true } })
            end, {})
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                },
            })

            vim.keymap.set("n", "<leader>m", function()
                harpoon:list():append()
                print("[Harpoon] mark: " .. vim.fn.expand("%:t"))
            end)

            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            for i = 1, 5 do
                vim.keymap.set("n", "<leader>" .. i, function()
                    harpoon:list():select(i)
                end)
            end
        end,
    },

    {
        "Exafunction/codeium.vim",
        cmd = { "CodeiumEnable" },
        config = function()
            vim.keymap.set("i", "<tab>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })
        end,
    },

    -- "echasnovski/mini.statusline",
    -- enabled = false,
    -- config = function()
    --     local statusline = require("mini.statusline")
    --     statusline.setup({ use_icons = false })
    --
    --     statusline.section_location = function()
    --         return "%3l:%-2v|%L"
    --     end
    --
    --     statusline.section_fileinfo = function()
    --         local filetype = vim.bo.filetype
    --         local encoding = vim.bo.fileencoding or vim.bo.encoding
    --         local format = vim.bo.fileformat
    --         return string.format("%s %s[%s]", filetype, encoding, format)
    --     end
    --
    --     statusline.section_lsp = function()
    --         return ""
    --     end
    --
    --     statusline.section_diagnostics = function()
    --         return ""
    --     end
    -- end,

    -- {
    --     "rest-nvim/rest.nvim",
    --     ft = { "http" },
    -- },

    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     enabled = false,
    --     opts = {
    --         indent = { char = " " },
    --         scope = {
    --             -- -- U+2502 may also be a good choice, it will be on the middle of cursor.
    --             -- -- U+250A is also a good choice
    --             char = "▏",
    --             highlight = { "Function", "Label" },
    --             show_start = false,
    --             show_end = false,
    --         },
    --         exclude = {
    --             filetypes = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha", "dashboard" },
    --             buftypes = { "terminal" },
    --         },
    --     },
    -- },
}
