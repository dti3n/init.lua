return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- opts = {},
    config = function()
        require("ibl").setup {
            indent = { char = " " },
            scope = {
                highlight = { "Function", "Label" },
                show_start = false,
                show_end = false,
                enabled = true,
                char = "┊",
            },
        }
    end
}

