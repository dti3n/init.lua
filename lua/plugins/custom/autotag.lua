return {
    "windwp/nvim-ts-autotag",
    -- event = { "BufReadPre", "BufNewFile" }
    ft = {
        "astro",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "markdown",
        "vue",
        "xml",
        "eruby",
        "php",
    },
    config = function()
        require("plugins/configs/autotag")
    end,
}
