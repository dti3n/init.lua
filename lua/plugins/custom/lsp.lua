return {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("plugins/configs/lsp")
    end,
}
