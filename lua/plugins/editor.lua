return {
    {
        "savq/melange-nvim",
        enabled = true,
        priority = 1000,
        init = function()
            vim.g.melange_enable_font_variants = false
            vim.cmd[[colorscheme melange]]
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },

    {
        'echasnovski/mini.statusline',
        version = false,
        config = function()
            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = false })

            -- statusline.section_git = function() return nil end
            statusline.section_diagnostics = function() return nil end
            statusline.section_fileinfo = function()
                local filetype = vim.bo.filetype
                local encoding = vim.bo.fileencoding or vim.bo.encoding
                local format = vim.bo.fileformat
                return string.format('%s %s [%s]', filetype, encoding, format)
            end
        end
    },

    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" },
        }
    },

    {
        'Exafunction/codeium.vim',
        -- cmd = { "Codeium" }
    },

    {
        "tpope/vim-sleuth",
        cmd = { "Sleuth" }
    },

    {
        'folke/trouble.nvim',
        keys = {
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        opts = {
            aliases = { ["b"] = "`", },
            surrounds = {
                ["b"] = { add = function() return { { "`" }, { "`" } } end },
                ["e"] = { add = function() return { { "<% " }, { " %>" } } end },
                ["="] = { add = function() return { { "<%= " }, { " %>" } } end },
            }
        }
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                }
            })

            vim.keymap.set("n", "<leader>m", function()
                harpoon:list():append()
                print('[Harpoon] mark: ' .. vim.fn.expand('%:t'))
            end)

            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        end
    },

    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        dependencies = {
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                config = function()
                    require('ts_context_commentstring').setup {
                        enable_autocmd = false,
                    }
                end
            },
        },
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                post_hook = nil,
            })
        end
    },

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
