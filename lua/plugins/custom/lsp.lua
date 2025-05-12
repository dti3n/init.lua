return {
    {
        "neovim/nvim-lspconfig",
        -- event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
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

            -- see :h vim.lsp.config
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                root_markers = {
                    ".git",
                    "tsconfig.json",
                    "jsconfig.json",
                    "package.json",
                },
                -- single_file_support = false
            })

            vim.lsp.config("tailwindcss", {
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

            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            mason.setup({})
            mason_lspconfig.setup({
                -- automatic_enable = false
                -- automatic_enable = {
                --     "ts_ls",
                --     "ruby_lsp,"
                -- }
            })

            -- completion ==========

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

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
}
