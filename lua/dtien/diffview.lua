vim.pack.add({
    "https://github.com/sindrets/diffview.nvim",
})

require("diffview").setup({
    use_icons = false,
})

vim.keymap.set("n", "\\df", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview: Toggle Files" })
vim.keymap.set("n", "\\dh", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview: File History" })
vim.keymap.set("n", "\\dH", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: Current File History" })
vim.keymap.set("n", "\\do", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: Open" })
