return {
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
                transparent = false,
                colors = { theme = { all = { ui = { bg_gutter = 'none' } }, }, },
            })
            vim.cmd[[colorscheme kanagawa]]
        end
    },

    { "tpope/vim-sleuth" },

    {

        "kylechui/nvim-surround",
        version = "*",
        opts = {
            surrounds = {
                ["="] = { add = function() return { { "<% " }, { " %>" } } end },
                ["e"] = { add = function() return { { "<%= " }, { " %>" } } end },
            }
        }
    },

    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                post_hook = nil,
            })
        end
    },

    {
        "folke/trouble.nvim",
        opts = { icons = false, },
        keys = {
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
        }
    },

    {
        'ThePrimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>m", function()
                mark.add_file()
                print('[Harpoon] mark: ' .. vim.fn.expand('%:t'))
            end, { desc = 'Harpoon: Add file' })

            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = 'Harpoon: Toggle quick-menu' })

            vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = 'Harpoon: Marked-file 1' })
            vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = 'Harpoon: Marked-file 2' })
            vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = 'Harpoon: Marked-file 3' })
            vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = 'Harpoon: Marked-file 4' })
            vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, { desc = 'Harpoon: Marked-file 5' })
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = " " },
            scope = {
                -- -- U+2502 may also be a good choice, it will be on the middle of cursor.
                -- -- U+250A is also a good choice
                char = "▏",
                highlight = { "Function", "Label" },
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha", "dashboard" },
                buftypes = { "terminal" },
            },
        },
    },

}
