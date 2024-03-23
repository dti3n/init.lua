return {
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" },
        }
    },

    {
        "tpope/vim-sleuth",
        -- cmd = { "Sleuth" }
    },

    {
        'folke/trouble.nvim',
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
        config = function()
            require("nvim-surround").setup({
                aliases = { ["b"] = "`", },
                surrounds = {
                    ["b"] = { add = function() return { { "`" }, { "`" } } end },
                    ["c"] = { add = function() return { { "{/* " }, { " */}" } } end },
                }
            })
            local v_chars = {"(", ")", "[", "]", "{", "}", "'", "\""}
            for _, char in pairs(v_chars) do
                vim.keymap.set("v", char, "<Plug>(nvim-surround-visual)"..char)
            end
        end
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
            vim.keymap.set("n", "<leader>5", function() harpoon:list():select(4) end)
        end
    },

    {
        -- better when at coffee shop
        'Exafunction/codeium.vim',
        event = "BufEnter",
        -- config = function()
        --     vim.g.codeium_enabled = false
        -- end
    },

    -- {
    --     "b0o/incline.nvim",
    --     event = "BufReadPre",
    --     priority = 1200,
    --     config = function()
    --         require("incline").setup({
    --             highlight = {
    --                 groups = {
    --                     InclineNormal = { guibg = "#8B008B", guifg = "#FFFFFF" },
    --                     InclineNormalNC = { guifg = "#8B008B", guibg = "#FFFFFF" },
    --                 },
    --             },
    --             window = { margin = { vertical = 0, horizontal = 0 } },
    --             hide = { cursorline = true, },
    --             -- render = function(props)
    --             --     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    --             --     if vim.bo[props.buf].modified then
    --             --         filename = "[+] " .. filename
    --             --     end
    --             --
    --             --     local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    --             --     return { { icon, guifg = color }, { " " }, { filename } }
    --             -- end,
    --         })
    --     end,
    -- },

    -- {
    --     'Wansmer/treesj',
    --     config = function()
    --         require('treesj').setup({ use_default_keymaps = false })
    --         vim.keymap.set('n', 'gs', require('treesj').split)
    --         vim.keymap.set('n', 'gj', require('treesj').join)
    --     end
    -- },

    -- {
    --     -- neovim now has native support for comment (runtime/vim/_comment.lua)
    --     'numToStr/Comment.nvim',
    --     dependencies = {
    --         {
    --             'JoosepAlviste/nvim-ts-context-commentstring',
    --             config = function()
    --                 require('ts_context_commentstring').setup {
    --                     enable_autocmd = false,
    --                 }
    --             end
    --         },
    --     },
    --     config = function()
    --         require('Comment').setup({
    --             pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    --             post_hook = nil,
    --         })
    --     end
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
