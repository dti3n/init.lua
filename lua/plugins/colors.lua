return {
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                commentStyle = { italic = false },
                functionStyle = { italic = false, bold = false },
                keywordStyle = { italic = false },
                statementStyle = { italic = false },
                typeStyle = { italic = false },
                colors = {
                    theme = {
                        all = { ui = { bg_gutter = 'none' } },
                    },
                },
            })
            vim.cmd[[colorscheme kanagawa]]
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        enabled = false,
        priority = 1000 ,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {
                    SignColumn = { bg = "#1d2021" }
                },
                dim_inactive = false,
                transparent_mode = false,
            })
            -- vim.cmd[[colorscheme gruvbox]]
        end
    },
    {
        'rose-pine/neovim',
        enabled = false,
        name = 'rose-pine',
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                variant = 'auto',
                dark_variant = 'moon',
                disable_italics = true,
                disable_background = false,
            })
            -- vim.cmd[[colorscheme rose-pine]]
        end
    }
}
