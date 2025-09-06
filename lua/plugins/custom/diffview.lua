return {
    "sindrets/diffview.nvim",
    opts = {
        use_icons = false,
    },
    keys = {
        { "\\do", "<cmd>DiffviewOpen<cr>" },
        { "\\df", "<cmd>DiffviewToggleFiles<cr>" },
        { "\\dh", "<cmd>DiffviewFileHistory<cr>" },
        { "\\dH", "<cmd>DiffviewFileHistory %<cr>" },
    },
    cmd = { "DiffviewOpen" },
}
