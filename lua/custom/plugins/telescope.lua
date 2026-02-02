return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    tag = "v0.2.0",
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local actions_layout = require("telescope.actions.layout")

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    ".git/",
                    ".node_modules/",
                },

                layout_config = {
                    width = 0.9,
                    height = 0.9,
                    -- horizontal = {
                    --     preview_width = 0.4,
                    -- },
                },

                preview = {
                    filesize_limit = 0.5, -- MB
                },

                mappings = {
                    i = {
                        ["<C-c>"] = false,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-y>"] = actions_layout.toggle_preview,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-y>"] = actions_layout.toggle_preview,
                    },
                },
            },

            pickers = {
                find_files = {
                    previewer = false,
                },
                git_files = {
                    previewer = false,
                },
            },
        })

        vim.keymap.set("n", "<C-p>", function()
            builtin.find_files({ hidden = true })
        end)

        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files({ hidden = true })
        end)

        vim.keymap.set("n", "<leader>ft", builtin.git_files)

        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })

        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elptag" })

        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind words by [G]rep" })

        vim.keymap.set("n", "<leader>fG", function()
            builtin.live_grep({ additional_args = { "--case-sensitive" } })
        end, { desc = "[F]ind words by [G]rep" })

        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })

        vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })

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

        vim.keymap.set("n", "<leader>pS", function()
            local ok, err = pcall(function()
                builtin.grep_string({
                    search = vim.fn.input("Grep > "),
                    previewer = true,
                    additional_args = { "--case-sensitive" },
                })
            end)
            if not ok then
                print("Error during grep: " .. err)
            end
        end, { desc = "[P]roject [S]earch --case-sensitive" })

        vim.keymap.set("n", "<leader>fw", function()
            word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "[F]ind [W]ord" })

        vim.keymap.set("n", "<leader>fW", function()
            word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "[F]ind [W]ORD" })
    end,
}
