return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {
                    -- "node_modules",
                },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                        ['<C-c>'] = false,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-q>'] = actions.send_to_qflist,
                        ['<M-q>'] = actions.add_selected_to_qflist,
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

        vim.keymap.set('n', '<leader>fw', function()
            word = vim.fn.expand('<cword>')
            builtin.grep_string({ search = word })
        end, { desc = '[F]ind [W]ord'})

        vim.keymap.set('n', '<leader>fW', function()
            word = vim.fn.expand('<cWORD>')
            builtin.grep_string({ search = word })
        end, { desc = '[F]ind [W]ORD'})
    end
}
