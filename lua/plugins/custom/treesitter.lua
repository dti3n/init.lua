return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    config = function()
        require("plugins/configs/treesitter")
    end,
}
