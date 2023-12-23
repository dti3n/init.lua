return {
    {
        "tpope/vim-rails",
        lazy = false,
        keys = {
            { "\\c", vim.cmd.Econtroller },
            { "\\v", vim.cmd.Eview },
            { "\\m", vim.cmd.Emodel },
            { "\\t", vim.cmd.Eunittest },
            { "\\r", vim.cmd.Runner },
        }
    },

    {
        "slim-template/vim-slim",
        ft = 'slim',
    }
}
