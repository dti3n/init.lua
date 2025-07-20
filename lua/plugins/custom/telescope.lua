return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    branch = "0.1.x",
    config = function()
        require("plugins/configs/telescope")
    end,
}
