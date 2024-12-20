return {
    {
        "tpope/vim-rails",
        ft = { "ruby", "eruby", "haml", "slim" },
        keys = {
            { "\\c", vim.cmd.Econtroller },
            { "\\v", vim.cmd.Eview },
            { "\\m", vim.cmd.Emodel },
        },
    },

    -- {
    --     "tpope/vim-haml",
    -- }
    --
    -- {
    --     "slim-template/vim-slim",
    --     ft = 'slim',
    -- }
}
