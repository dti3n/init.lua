return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
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
                -- selection_caret = "󰼛 ",
                -- prompt_prefix = "󱞩 ",
                mappings = {
                    i = {
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
                -- -- layout_strategy = 'horizontal',
                -- -- sorting_strategy = "ascending",
                -- layout_config = {
                --     -- prompt_position = "top",
                --     height = 0.90,
                --     width = 0.90
                -- },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    theme = "dropdown",
                },
                git_files = {
                    previewer = false,
                    theme = "dropdown",
                }
            },
        }

        local is_inside_work_tree = {}

        local project_files = function()
            local opts = {} -- define here if you want to define something

            local cwd = vim.fn.getcwd()
            if is_inside_work_tree[cwd] == nil then
                vim.fn.system("git rev-parse --is-inside-work-tree")
                is_inside_work_tree[cwd] = vim.v.shell_error == 0
            end

            if is_inside_work_tree[cwd] then
                require("telescope.builtin").git_files(opts)
            else
                require("telescope.builtin").find_files(opts)
            end
        end

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<C-p>', project_files, { desc = 'Project Files: git_files or find_files (fallback)' })
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
