return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            -- see :h vim.lsp.config
            vim.lsp.config("ts_ls", {
                root_markers = {
                    ".git",
                    "tsconfig.json",
                    "jsconfig.json",
                    "package.json",
                },
                -- single_file_support = false
            })

            vim.lsp.config("tailwindcss", {
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "svelte",
                },
            })

            require("mason").setup({})
            require("mason-lspconfig").setup({})
        end,
    },
}
