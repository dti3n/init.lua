return {
    "tamago324/lir.nvim",
    enabled = true,
    dependencies = {
        {
            "tamago324/lir-git-status.nvim",
            config = function()
                require("lir.git_status").setup {
                    show_ignored = false,
                }
            end
        }
    },
    config = function()
        local actions = require'lir.actions'
        local mark_actions = require 'lir.mark.actions'
        local clipboard_actions = require'lir.clipboard.actions'

        require('lir').setup({
            show_hidden_files = true,

            devicons = {
                enable = true,
            },

            float = { winblend = 0 },

            mappings = {
                ["<CR>"] = actions.edit,
                ["o"] = actions.edit,
                ["-"] = actions.up,
                ['q'] = actions.quit,

                ["d"] = actions.mkdir,
                ["a"] = actions.newfile,
                ["r"] = actions.rename,
                ["Y"] = actions.yank_path,
                ["D"] = actions.delete,
                ["."] = actions.toggle_show_hidden,

                ['J'] = function()
                    mark_actions.toggle_mark()
                    vim.cmd('normal! j')
                end,

                ['C'] = clipboard_actions.copy,
                ['X'] = clipboard_actions.cut,
                ['P'] = clipboard_actions.paste,
            },
            hide_cursor = false
        })

        vim.api.nvim_create_autocmd({'FileType'}, {
            pattern = { "lir" },
            callback = function()
                -- use visual mode
                vim.api.nvim_buf_set_keymap(
                    0,
                    "x",
                    "J",
                    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                    { noremap = true, silent = true }
                )

                -- echo cwd
                vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
            end
        })

        vim.keymap.set('n', '<leader>vn', require'lir.float'.toggle)
    end
}
