return {
    {
        "tpope/vim-rails",
        lazy = false,
        keys = {
            { "\\c", vim.cmd.Econtroller },
            { "\\v", vim.cmd.Eview },
            { "\\m", vim.cmd.Emodel },
        }
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
