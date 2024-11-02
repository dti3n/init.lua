return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    config = function()
        require("plugins/configs/telescope")
    end,
}
