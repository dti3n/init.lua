return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", vim.cmd.Git, silent = true },
            { "<leader>gb", "<cmd>Git blame<cr>", silent = true },
            { "<leader>gl", "<cmd>Git log --oneline<cr>", silent = true },
            { "<leader>gL", "<cmd>Git log --oneline %<cr>", silent = true },
            { "gh", "<cmd>diffget //2<CR>" },
            { "gl", "<cmd>diffget //3<CR>" },
        },
        -- config = function()
        --     -- :help fugitive#statusline()
        --     vim.o.statusline = '%f %h%m%r %{FugitiveStatusline()}%=%-14.(%l,%c%V%) %L/%P'
        -- end
    },

    {
        "sindrets/diffview.nvim",
        lazy = true,
        opts = {},
        keys = {
            { "\\df", "<cmd>DiffviewToggleFiles<cr>" },
            { "\\dh", "<cmd>DiffviewFileHistory<cr>" },
            { "\\dH", "<cmd>DiffviewFileHistory %<cr>" },
        },
    },

    -- {
    --     'lewis6991/gitsigns.nvim',
    --     enabled = false,
    --     config = function()
    --         require('gitsigns').setup({
    --             max_file_length = 2000, -- Disable if file is longer than this (in lines)
    --
    --             signs = {
    --                 add = { text = '+' },
    --                 change = { text = '~' },
    --                 delete = { text = '_' },
    --                 topdelete = { text = '‾' },
    --                 changedelete = { text = '~' },
    --                 untracked    = { text = '┆' },
    --             },
    --
    --             signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    --             numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    --             linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    --             word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    --
    --             current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d %H:%M> - <summary>',
    --
    --             on_attach = function(bufnr)
    --                 local gs = package.loaded.gitsigns
    --
    --                 vim.keymap.set('n', '<leader>hu', gs.prev_hunk, { buffer = bufnr })
    --                 vim.keymap.set('n', '<leader>hd', gs.next_hunk, { buffer = bufnr })
    --                 vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr })
    --                 vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end)
    --                 vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
    --             end
    --         })
    --     end,
    -- },
}
