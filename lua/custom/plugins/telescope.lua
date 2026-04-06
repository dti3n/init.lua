return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    tag = "v0.2.0",
    config = function()
        require("custom/configs/telescope")
    end,
}
