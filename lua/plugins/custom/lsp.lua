return {
    {
        "neovim/nvim-lspconfig",
        -- event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- mason.nvim must be loaded before dependants
            { "williamboman/mason.nvim", config = true },
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

                tailwindcss = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tailwindcss.setup({
                        capabilities = capabilities,
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
                end,
            })
        end,
    },

    {
        "mfussenegger/nvim-lint",
        ft = { "ruby", "php" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                ruby = { "ruby" },
                php = { "php" },
            }

            local ns = require("lint").get_namespace("rubocop")
            vim.diagnostic.config({
                -- float = { border = "single" }, -- :help nvim_open_win()
                underline = {
                    severity = { min = vim.diagnostic.severity.ERROR },
                },
                virtual_text = {
                    severity = { min = vim.diagnostic.severity.WARN },
                },
                signs = true,
            }, ns)

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })

            if vim.bo.filetype == "ruby" then
                vim.api.nvim_create_user_command("Rubocop", function()
                    vim.diagnostic.reset(ns)
                    lint.try_lint("rubocop")
                end, {})
            end
        end,
    },
}
