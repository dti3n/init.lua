function on_background_change(settings)
    settings = settings or {}
    local bg_mode = vim.o.background
    local theme = settings.theme
    local config = settings[bg_mode] or { color = "default" }
    local setup = config.setup
    if theme then
        local ok, err = pcall(function() require(theme) end)
        if not ok then
            print("Failed to load colorscheme")
            return
        end

        require(theme).setup(setup or {})
    end

    vim.cmd("colorscheme " .. config.color)
end

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
                    emphasis = true,
                    comments = false,
                    operators = false,
                    folds = true,
                },
                transparent_mode = true,
                contrast = "",
            })
            vim.cmd[[colorscheme gruvbox]]
        end,
    },

    {
        "savq/melange-nvim",
        enabled = false,
        priority = 1000,
        lazy = false,
        init = function()
            vim.g.melange_enable_font_variants = { italic = false }
            vim.cmd("colorscheme melange")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            local settings = {
                theme = "rose-pine",
                dark = {
                    color = "rose-pine-moon",
                    setup = {
                        styles = {
                            bold = true,
                            italic = false,
                            transparency = true,
                        },
                    }
                },
                light = {
                    color = "rose-pine-dawn",
                    setup = {
                        styles = {
                            bold = true,
                            italic = false,
                            transparency = false,
                        },
                    }
                },
            }
            on_background_change(settings)
            vim.api.nvim_create_autocmd("OptionSet", {
                pattern = "background",
                callback = function()
                    on_background_change(settings)
                end
            })
        end,
    },
}

