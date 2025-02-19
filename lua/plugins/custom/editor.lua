return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" },
        },
    },

    {
        "tpope/vim-sleuth",
        -- cmd = "Sleuth",
    },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    {
        "folke/trouble.nvim",
        opts = {},
        keys = {
            {
                "<leader>xl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                aliases = { ["b"] = "`" },
                surrounds = {
                    ["b"] = {
                        add = function()
                            return { { "`" }, { "`" } }
                        end,
                    },
                    ["c"] = {
                        add = function()
                            return { { "{/* " }, { " */}" } }
                        end,
                    },
                },
            })
            local v_chars = { "(", ")", "[", "]", "{", "}", "'", '"', "`" }
            for _, char in pairs(v_chars) do
                vim.keymap.set(
                    "v",
                    char,
                    "<Plug>(nvim-surround-visual)" .. char
                )
            end
        end,
    },

    {
        "Wansmer/treesj",
        keys = { "gs", "gS" },
        opts = { use_default_keymaps = false, max_join_length = 150 },
        config = function()
            vim.keymap.set("n", "gs", require("treesj").toggle)
            vim.keymap.set("n", "gS", function()
                require("treesj").toggle({ split = { recursive = true } })
            end)
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                },
            })

            vim.keymap.set("n", "<leader>m", function()
                harpoon:list():append()
                print("[Harpoon] mark: " .. vim.fn.expand("%:t"))
            end, { desc = "harpoon mark" })

            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "harpoon quick menu" })

            for i = 1, 5 do
                vim.keymap.set("n", "<leader>" .. i, function()
                    harpoon:list():select(i)
                end, { desc = "harpoon select mark " .. i })
            end
        end,
    },

    {
        "rest-nvim/rest.nvim",
        ft = "http",
        config = function()
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = "*.http",
                callback = function()
                    if vim.fn.filereadable(".env") == 1 then
                        local env_file = ".env"
                        vim.cmd("Rest env set " .. env_file)
                        return
                    end
                    if vim.fn.filereadable(".env.dev") == 1 then
                        local env_file = ".env.dev"
                        vim.cmd("Rest env set " .. env_file)
                    end
                end,
            })
        end,
    },

    {
        "Exafunction/codeium.vim",
        cmd = { "CodeiumEnable" },
        config = function()
            vim.g.codeium_disable_bindings = 1

            vim.keymap.set("i", "<C-g>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<c-;>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<c-,>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<c-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<Tab>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })

            vim.cmd([[set statusline+=\{…\}%3{codeium#GetStatusString()}]])
        end,
    },
}
