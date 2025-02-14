return {
    {
        "neovim/nvim-lspconfig",
        -- event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- mason.nvim must be loaded before dependants
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                cmp_lsp.default_capabilities()
            )

            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

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

            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                cmp_lsp.default_capabilities()
            )

            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

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

            -- completion ==========

            cmp.setup({
                -- window = {
                --     completion = cmp.config.window.bordered(),
                --     documentation = cmp.config.window.bordered(),
                -- },

                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    -- ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-j>'] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    }),
                    ["Tab"] = nil,
                    ["S-Tab"] = nil,
                }),

                sources = {
                    { name = "nvim_lsp", max_item_count = 10 },
                    { name = "path" },
                },
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
