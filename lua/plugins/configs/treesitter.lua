require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "vimdoc",
        "jsdoc",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "ruby",
        "php",
        "bash",

        -- for autotag to works
        "html",
        "embedded_template",
    },

    auto_install = false,
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby", "php", "markdown" },
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 0.1 MB
            local ok, stats =
                pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },

    indent = {
        enable = true,
        disable = { "ruby" },
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-h>",
            node_decremental = "<c-s>",
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["at"] = "@tag.outer",
                ["it"] = "@tag.inner",
            },
        },
        -- move = {
        --     enable = true,
        --     set_jumps = true, -- whether to set jumps in the jumplist
        --     goto_next_start = {
        --         [']m'] = '@function.outer',
        --         [']]'] = '@class.outer',
        --     },
        --     goto_next_end = {
        --         [']M'] = '@function.outer',
        --         [']['] = '@class.outer',
        --     },
        --     goto_previous_start = {
        --         ['[m'] = '@function.outer',
        --         ['[['] = '@class.outer',
        --     },
        --     goto_previous_end = {
        --         ['[M'] = '@function.outer',
        --         ['[]'] = '@class.outer',
        --     },
        -- },
        -- swap = {
        --     enable = true,
        --     swap_next = {
        --         ['<leader>a'] = '@parameter.inner',
        --         -- ['<leader>c'] = '@class.outer',
        --         -- ['<leader>m'] = '@function.outer',
        --     },
        --     swap_previous = {
        --         ['<leader>A'] = '@parameter.inner',
        --         -- ['<leader>C'] = '@class.outer',
        --         -- ['<leader>M'] = '@function.outer',
        --     },
        -- },
    },
})

-- require("treesitter-context").setup({
--     enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
--     multiwindow = false, -- Enable multiwindow support.
--     max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--     min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--     line_numbers = true,
--     multiline_threshold = 2, -- Maximum number of lines to show for a single context
--     trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--     mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
--     -- Separator between context and content. Should be a single character string, like '-'.
--     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--     separator = "-",
--     zindex = 20, -- The Z-index of the context window
--     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- })
--
-- vim.keymap.set("n", "\\tc", "<cmd>TSContextToggle<CR>")
--
-- -- local color_column_bg = vim.api.nvim_get_hl(0, { name = "NonText" }).fg or "#303030"
-- vim.api.nvim_set_hl(0, "TreeSitterContext", { bg = "none" })
-- vim.api.nvim_set_hl(
--     0,
--     "TreeSitterContextSeparator",
--     { bg = "none", fg = "#303030" }
-- )
