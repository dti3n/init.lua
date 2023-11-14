return {
    "folke/trouble.nvim",
    opts = {
        icons = false,
    },
    keys = {
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
    }
}
