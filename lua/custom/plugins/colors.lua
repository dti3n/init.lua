return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        lazy = false,
        config = function()
            require("rose-pine").setup({
                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                },
                highlight_groups = {
                    StatusLine = { fg = "subtle", bg = "overlay", blend = 30 },
                    StatusLineNC = { fg = "subtle", bg = "overlay", blend = 30 },
                    ColorColumn = { fg = "subtle", bg = "overlay", blend = 30 },
                },
            })
            vim.cmd("colorscheme rose-pine-moon")
        end,
    },

    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     priority = 1000,
    --     enabled = true,
    --     lazy = false,
    --     config = function()
    --         require("gruvbox").setup({
    --             italic = {
    --                 strings = false,
    --                 emphasis = false,
    --                 comments = false,
    --                 operators = false,
    --                 folds = true,
    --             },
    --             transparent_mode = true,
    --         })
    --         vim.cmd([[colorscheme gruvbox]])
    --     end,
    -- },

    -- {
    --     "sainnhe/gruvbox-material",
    --     enabled = false,
    --     priority = 1000,
    --     config = function()
    --         vim.g.gruvbox_material_foreground = "material"
    --         vim.g.gruvbox_material_enable_italic = true
    --         vim.g.gruvbox_material_transparent_background = true
    --         vim.cmd([[colorscheme gruvbox-material]])
    --     end,
    -- },
}
