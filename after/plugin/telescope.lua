local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local trouble = require("trouble.providers.telescope")

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git",
        },
        mappings = {
            i = {
                ['<C-q>'] = actions.add_to_qflist,
                ['<C-a>'] = trouble.open_with_trouble,
            },
           n = {
                ["q"] = actions.close,
                ['<C-q>'] = actions.add_to_qflist,
                ['<C-a>'] = trouble.open_with_trouble,
            },
        },
    },
    -- pickers = {
    --     find_files = {
    --         theme = "dropdown",
    --     }
    -- },
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elptag' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind words by [G]rep' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymap' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = '[P]roject [S]earch'})
