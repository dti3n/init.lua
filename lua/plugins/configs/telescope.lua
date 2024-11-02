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
            },
            n = {
                ["q"] = actions.close,
            },
        },
    },
})

local is_inside_work_tree = {}

local project_files = function()
    local opts = {}

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

vim.keymap.set(
    "n",
    "<C-p>",
    project_files,
    { desc = "Project Files: use git_files or fallback to find_files" }
)

vim.keymap.set(
    "n",
    "<leader>ff",
    builtin.find_files,
    { desc = "[F]ind [F]iles" }
)
vim.keymap.set("n", "<leader>fF", function()
    builtin.find_files({ hidden = true })
end, { desc = "[F]ind [F]iles (include hidden files)" })

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
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymap" })
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

-- Find marks (see :help marks)
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[F]ind [M]arks" })

vim.keymap.set("n", "<leader>ps", function()
    local ok, err = pcall(function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
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
