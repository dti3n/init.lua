local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            ".git/",
            ".node_modules/",
        },

        preview = {
            filesize_limit = 0.1, -- MB
        },

        mappings = {
            i = {
                ["<C-c>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
            },
            n = {
                ["q"] = actions.close,
                ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
            },
        },
    },

    pickers = {
        -- find_files = {
        --     previewer = false,
        -- },
        -- git_files = {
        --     previewer = false,
        -- },
    },
})

vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<leader>ft", builtin.git_files)
vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files({ hidden = true })
end)

vim.keymap.set(
    "n",
    "<leader>fb",
    builtin.buffers,
    { desc = "[F]ind [B]uffers" }
)

vim.keymap.set(
    "n",
    "<leader>fh",
    builtin.help_tags,
    { desc = "[F]ind [H]elptag" }
)

vim.keymap.set(
    "n",
    "<leader>fg",
    builtin.live_grep,
    { desc = "[F]ind words by [G]rep" }
)

vim.keymap.set(
    "n",
    "<leader>fd",
    builtin.diagnostics,
    { desc = "[F]ind [D]iagnostics" }
)

vim.keymap.set(
    "n",
    "<leader>?",
    builtin.oldfiles,
    { desc = "[?] Find recently opened files" }
)

-- Find keymaps
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymap" })

-- Find marks (see :help marks)
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[F]ind [M]arks" })

vim.keymap.set("n", "<leader>ps", function()
    local ok, err = pcall(function()
        builtin.grep_string({
            search = vim.fn.input("Grep > "),
            previewer = true,
        })
    end)
    if not ok then
        print("Error during grep: " .. err)
    end
end, { desc = "[P]roject [S]earch" })

vim.keymap.set("n", "<leader>fw", function()
    word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
end, { desc = "[F]ind [W]ord" })

vim.keymap.set("n", "<leader>fW", function()
    word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end, { desc = "[F]ind [W]ORD" })
