return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        -- dependencies = {
        --     "nvim-treesitter/nvim-treesitter-textobjects",
        --     "nvim-treesitter/nvim-treesitter-context",
        -- },
        build = ":TSUpdate",
        config = function()
            require("plugins/configs/treesitter")
        end,
    },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    {
        "Wansmer/treesj",
        keys = { "gs", "gS" },
        opts = { use_default_keymaps = false, max_join_length = 150 },
        config = function()
            vim.keymap.set("n", "gs", require("treesj").toggle)
            vim.keymap.set("n", "gS", function()
                require("treesj").toggle({ split = { recursive = true } })
            end)
        end,
    },
}
