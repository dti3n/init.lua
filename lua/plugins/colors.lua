return {

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        init = function()
            require("gruvbox").setup({
                italic = {
                    strings = false,
                    emphasis = true,
                    comments = false,
                    operators = false,
                    folds = true,
                },
                transparent_mode = false,
                contrast = "hard",
            })
            vim.cmd[[colorscheme gruvbox]]
        end,
    },

    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     enabled = true,
    --     lazy = false,
    --     priority = 1000,
    --     init = function()
    --         require("rose-pine").setup({
    --             styles = {
    --                 bold = true,
    --                 italic = false,
    --                 transparency = false,
    --             },
    --         })
    --         vim.cmd[[colorscheme rose-pine]]
    --     end,
    -- },

    -- {
    --     "savq/melange-nvim",
    --     enabled = true,
    --     lazy = false,
    --     priority = 1000,
    --     init = function()
    --         vim.g.melange_enable_font_variants = false
    --         vim.cmd[[colorscheme melange]]
    --         -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --         -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --     end,
    -- },

}
