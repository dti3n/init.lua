return {
    {
        "tpope/vim-rails",
        ft = { "ruby", "eruby", "haml", "slim" },
        config = function()
            vim.keymap.set("n", "\\c", "<cmd>Econtroller<CR>")
            vim.keymap.set("n", "\\v", "<cmd>Eview<CR>")
            vim.keymap.set("n", "\\m", "<cmd>Emodel<CR>")
        end,
    },

    -- {
    --     "tpope/vim-haml",
    --     ft = "haml",
    -- },
    --
    -- {
    --     "slim-template/vim-slim",
    --     ft = "slim",
    -- },
}
