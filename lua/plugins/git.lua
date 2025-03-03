return {
    {
        'tpope/vim-fugitive',
        lazy = false,
        keys = {
            { "<leader>gs", vim.cmd.Git, silent = true },
            { "<leader>gb", "<cmd>Git blame<cr>", silent = true },
            { "<leader>gl", "<cmd>Git log --oneline<cr>", silent = true },
            { "<leader>gL", "<cmd>Git log --oneline %<cr>", silent = true },
            { "gh", "<cmd>diffget //2<CR>"},
            { "gl", "<cmd>diffget //3<CR>"},
        },
    },
}
