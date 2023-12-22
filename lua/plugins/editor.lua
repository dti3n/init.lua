return {
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
            })
            vim.cmd[[colorscheme kanagawa]]
        end
    },

    {
        'nmac427/guess-indent.nvim',
        enabled = true,
        config = function()
            require('guess-indent').setup({
                auto_cmd = false,  -- Set to false to disable automatic execution
                override_editorconfig = false, -- Set to true to override settings set by .editorconfig
                filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
                    "netrw",
                    "tutor",
                },
                buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
                    "help",
                    "nofile",
                    "terminal",
                    "prompt",
                },
            })
        end
    },


    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" },
        }
    },

    {

        "kylechui/nvim-surround",
        version = "*",
        opts = {
            surrounds = {
                ["e"] = { add = function() return { { "<% " }, { " %>" } } end },
                ["="] = { add = function() return { { "<%= " }, { " %>" } } end },
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
        enabled = false,
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
