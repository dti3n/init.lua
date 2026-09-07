vim.pack.add({
    "https://github.com/tpope/vim-fugitive",
})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline<cr>")
vim.keymap.set("n", "<leader>gL", "<cmd>Git log --oneline %<cr>")
