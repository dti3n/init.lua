return {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gl", ":Git log -n100 <CR>", { silent = true })
        vim.keymap.set("n", "<leader>gL", ":Git log -n100 %<CR>", { silent = true })
        vim.keymap.set("n", "<leader>gb", ":Git blame %<CR>", { silent = true })
    end,
}
