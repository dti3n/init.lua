return {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        mason_lspconfig.setup_handlers({
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            denols = function()
                local lspconfig = require("lspconfig")
                lspconfig.denols.setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern(
                        "deno.json",
                        "deno.jsonc"
                    ),
                })
            end,

            ts_ls = function()
                local lspconfig = require("lspconfig")
                lspconfig.ts_ls.setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern(
                        ".git",
                        "tsconfig.json",
                        "jsconfig.json",
                        "package.json"
                    ),
                    -- single_file_support = false
                })
            end,
        })
    end,
}
