return {
    {
        'tpope/vim-fugitive',
        lazy = false,
        keys = {
            { "<leader>gs", vim.cmd.Git },
            { "gh", "<cmd>diffget //2<CR>"},
            { "gl", "<cmd>diffget //3<CR>"},
        }
    },

    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },

                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

                on_attach = function(bufnr)
                    vim.keymap.set('n', '<leader>hu', require('gitsigns').prev_hunk, { buffer = bufnr })
                    vim.keymap.set('n', '<leader>hd', require('gitsigns').next_hunk, { buffer = bufnr })
                    vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr })
                end
            })

            vim.cmd[[:highlight GitSignsAdd guibg=none]]
            vim.cmd[[:highlight GitSignsChange guibg=none]]
            vim.cmd[[:highlight GitSignsDelete guibg=none]]
        end,
    },
}
