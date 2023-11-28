return {
    { "nvim-tree/nvim-web-devicons", enabled = true, lazy = true },

    { 'tpope/vim-sleuth' },

    {
        "folke/trouble.nvim",
        opts = {
            icons = false,
        },
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

            vim.keymap.set("n", [[\1]], function() ui.nav_file(1) end, { desc = 'Harpoon: Marked-file 1' })
            vim.keymap.set("n", [[\2]], function() ui.nav_file(2) end, { desc = 'Harpoon: Marked-file 2' })
            vim.keymap.set("n", [[\3]], function() ui.nav_file(3) end, { desc = 'Harpoon: Marked-file 3' })
            vim.keymap.set("n", [[\4]], function() ui.nav_file(4) end, { desc = 'Harpoon: Marked-file 4' })
            vim.keymap.set("n", [[\5]], function() ui.nav_file(5) end, { desc = 'Harpoon: Marked-file 5' })

            -- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = 'Harpoon: Marked-file 1' })
            -- vim.keymap.set("n", "<C-g>", function() ui.nav_file(2) end, { desc = 'Harpoon: Marked-file 2' })
            -- vim.keymap.set("n", "<C-y>", function() ui.nav_file(3) end, { desc = 'Harpoon: Marked-file 3' })
            -- vim.keymap.set("n", "<C-t>", function() ui.nav_file(4) end, { desc = 'Harpoon: Marked-file 4' })
        end
    },

    {
        "tamago324/lir.nvim",
        enabled = true,
        dependencies = {
            {
                "tamago324/lir-git-status.nvim",
                config = function()
                    require("lir.git_status").setup {
                        show_ignored = false,
                    }
                end
            }
        },
        config = function()
            local actions = require'lir.actions'
            local mark_actions = require 'lir.mark.actions'
            local clipboard_actions = require'lir.clipboard.actions'

            require('lir').setup({
                show_hidden_files = true,

                devicons = {
                    enable = false,
                },

                ignore = {
                    "node_modules"
                },

                float = { winblend = 0 },

                mappings = {
                    ["<CR>"] = actions.edit,
                    ["o"] = actions.edit,
                    ["-"] = actions.up,
                    ['q'] = actions.quit,

                    ["d"] = actions.mkdir,
                    ["a"] = actions.newfile,
                    ["r"] = actions.rename,
                    ["Y"] = actions.yank_path,
                    ["D"] = actions.delete,
                    ["."] = actions.toggle_show_hidden,

                    ['J'] = function()
                        mark_actions.toggle_mark()
                        vim.cmd('normal! j')
                    end,

                    ['C'] = clipboard_actions.copy,
                    ['X'] = clipboard_actions.cut,
                    ['P'] = clipboard_actions.paste,
                },
                hide_cursor = false
            })

            vim.api.nvim_create_autocmd({'FileType'}, {
                pattern = { "lir" },
                callback = function()
                    -- use visual mode
                    vim.api.nvim_buf_set_keymap(
                        0,
                        "x",
                        "J",
                        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                        { noremap = true, silent = true }
                    )

                    -- echo cwd
                    vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
                end
            })

            vim.keymap.set('n', '<leader>vn', require'lir.float'.toggle)
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        ".git",
                    },
                    mappings = {
                        i = {
                            ['<C-c>'] = false,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        },
                        n = {
                            ['q'] = actions.close,
                        },
                    },
                    layout_strategy = 'horizontal',
                    sorting_strategy = "ascending",
                    layout_config = {
                        prompt_position = "top",
                        height = 0.90,
                        width = 0.90
                    },
                },
                -- pickers = {
                --     find_files = {
                --         previewer = false,
                --         theme = "dropdown",
                --     },
                --     git_files = {
                --         previewer = false,
                --         theme = "dropdown",
                --     }
                -- },
            }

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = '[G]it [F]iles' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elptag' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind words by [G]rep' })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymap' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
            vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end, { desc = '[P]roject [S]earch'})
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = " " },
            scope = {
                highlight = { "Function", "Label" },
                show_start = false,
                show_end = false,
                enabled = true,
                char = "┊",
            },
        },
    },

    {
        'VonHeikemen/fine-cmdline.nvim',
        enabled = false,
        dependencies = {
            { 'MunifTanjim/nui.nvim' }
        },
        config = function()
            require('fine-cmdline').setup({
                cmdline = {
                    enable_keymaps = true,
                    smart_history = true,
                    prompt = ' : '
                },
                popup = {
                    position = {
                        row = '40%',
                        col = '50%',
                    },
                    size = {
                        width = '60%',
                    },
                    border = {
                        style = 'rounded',
                    },
                },
                hooks = {
                    after_mount = function(input)
                        vim.keymap.set('i', '<Esc>', '<cmd>stopinsert<cr>', { buffer = input.bufnr })
                    end,
                },
            })
            vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
        end,
    }
}
