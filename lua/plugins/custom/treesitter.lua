return {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
        require("plugins/configs/treesitter")
    end,
}
