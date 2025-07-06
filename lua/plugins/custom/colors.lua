return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        enabled = true,
        lazy = false,
        config = function()
            require("gruvbox").setup({
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = true,
                },
                transparent_mode = true,
            })
            vim.cmd([[colorscheme gruvbox]])
        end,
    },

    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     priority = 1000,
    --     enabled = false,
    --     lazy = false,
    --     config = function()
    --         require("rose-pine").setup({
    --             styles = {
    --                 bold = true,
    --                 italic = false,
    --                 transparency = true,
    --             },
    --             highlight_groups = {
    --                 Directory = { fg = "#68998a" },
    --                 StatusLine = { fg = "subtle", bg = "overlay", blend = 20 },
    --                 StatusLineNC = { fg = "subtle", bg = "overlay", blend = 20 },
    --                 ColorColumn = { fg = "subtle", bg = "overlay", blend = 20 },
    --             },
    --         })
    --         vim.cmd("colorscheme rose-pine-moon")
    --     end,
    -- },

    -- {
    --     "rebelot/kanagawa.nvim",
    --     enabled = true,
    --     priority = 1000,
    --     config = function()
    --         require("kanagawa").setup({
    --             transparent = true,
    --             colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    --             overrides = function(colors)
    --                 local theme = colors.theme
    --                 return {
    --                     NormalFloat = { bg = "none" },
    --                     FloatBorder = { bg = "none" },
    --                     FloatTitle = { bg = "none" },
    --                     TelescopeTitle = { fg = theme.ui.special, bold = true },
    --                     TelescopePromptNormal = { bg = theme.ui.bg_p1 },
    --                     TelescopePromptBorder = {
    --                         fg = theme.ui.bg_p1,
    --                         bg = theme.ui.bg_p1,
    --                     },
    --                     TelescopeResultsNormal = {
    --                         fg = theme.ui.fg_dim,
    --                         bg = theme.ui.bg_m1,
    --                     },
    --                     TelescopeResultsBorder = {
    --                         fg = theme.ui.bg_m1,
    --                         bg = theme.ui.bg_m1,
    --                     },
    --                     TelescopePreviewNormal = { bg = theme.ui.bg_dim },
    --                     TelescopePreviewBorder = {
    --                         bg = theme.ui.bg_dim,
    --                         fg = theme.ui.bg_dim,
    --                     },
    --                 }
    --             end,
    --         })
    --         vim.cmd([[colorscheme kanagawa-dragon]])
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

    -- {
    --     "savq/melange-nvim",
    --     priority = 1000,
    --     enabled = false,
    --     lazy = false,
    --     config = function()
    --         vim.g.melange_enable_font_variants = { italic = false }
    --         vim.cmd("colorscheme melange")
    --         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --         -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#34302C" })
    --     end,
    -- },

    -- {
    --     "rebelot/kanagawa.nvim",
    --     priority = 1000,
    --     enabled = true,
    --     lazy = false,
    --     config = function()
    --         require("kanagawa").setup({
    --             transparent = true,
    --             colors = {
    --                 theme = {
    --                     all = {
    --                         ui = {
    --                             bg_gutter = "none",
    --                         },
    --                     },
    --                 },
    --             },
    --         })
    --         vim.cmd([[colorscheme kanagawa]])
    --     end,
    -- },

    -- {
    --     "sainnhe/sonokai",
    --     priority = 1000,
    --     enabled = true,
    --     lazy = false,
    --     config = function()
    --         vim.g.sonokai_transparent_background = 1
    --         vim.cmd("colorscheme sonokai")
    --     end,
    -- },

    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             transparent_background = true,
    --             flavour = "mocha",
    --             background = {
    --                 light = "latte",
    --                 dark = "mocha",
    --             },
    --             color_overrides = {
    --                 mocha = {
    --                     rosewater = "#ffffff",
    --                     flamingo = "#ffffff",
    --                     red = "#ffdd33",
    --                     maroon = "#ffffff",
    --                     pink = "#ffdd33",
    --                     mauve = "#ffdd33",
    --                     peach = "#96a6c8",
    --                     yellow = "#899b92",
    --                     green = "#73c936",
    --                     teal = "#88b992",
    --                     sky = "#cc8c3c",
    --                     sapphire = "#96a6c8",
    --                     blue = "#778899",
    --                     lavender = "#778899",
    --                     text = "#eae3d5",
    --                     subtext1 = "#d5c9b7",
    --                     subtext0 = "#bfb3a5",
    --                     overlay2 = "#aca195",
    --                     overlay1 = "#958b7e",
    --                     overlay0 = "#6f6660",
    --                     surface2 = "#585858",
    --                     surface1 = "#4b4b4b",
    --                     surface0 = "#353535",
    --                     base = "#181818",
    --                     mantle = "#1d2021",
    --                     crust = "#1d2021",
    --                 }
    --             }
    --         })
    --         vim.cmd([[colorscheme catppuccin]])
    --     end
    -- },
}
