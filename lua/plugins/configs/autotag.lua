require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true, -- Auto close tags
        enable_rename = false, -- Auto rename pairs of tags (default true)
        enable_close_on_slash = false, -- Auto close on trailing </
    },
    per_filetype = {
        ["erb"] = {
            enable_close = true,
        },
        ["php"] = {
            enable_close = true,
        },
    },
})
