return {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("plugins/configs/treesitter")
    end,
}
