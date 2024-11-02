return {
    "tamago324/lir.nvim",
    enabled = true,
    config = function()
        local actions = require("lir.actions")
        local mark_actions = require("lir.mark.actions")
        local clipboard_actions = require("lir.clipboard.actions")

        require("lir").setup({
            show_hidden_files = true,

            devicons = {
                enable = true,
                highlight_dirname = false,
            },

            float = {
                winblend = 0,
                -- curdir_window = {
                --     enable = true,
                --     highlight_dirname = true,
                -- }
            },

            hide_cursor = false,

            mappings = {
                ["<CR>"] = actions.edit,
                ["-"] = actions.up,
                ["q"] = actions.quit,

                ["d"] = actions.mkdir,
                ["a"] = actions.newfile,
                ["R"] = actions.rename,
                ["Y"] = actions.yank_path,
                -- ["D"] = actions.delete,
                ["D"] = actions.wipeout,
                ["v"] = actions.vsplit,
                ["o"] = actions.split,
                ["t"] = actions.tabedit,
                ["."] = actions.toggle_show_hidden,

                ["J"] = function()
                    mark_actions.toggle_mark()
                    vim.cmd("normal! j")
                end,

                ["C"] = clipboard_actions.copy,
                ["X"] = clipboard_actions.cut,
                ["P"] = clipboard_actions.paste,
            },
        })

        vim.api.nvim_create_autocmd({ "FileType" }, {
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

                -- set winbar with relative path
                vim.opt_local.winbar = ' %{v:lua.vim.fn.expand("%:p")} '

                -- echo cwd
                vim.api.nvim_echo(
                    { { vim.fn.expand("%:p"), "Normal" } },
                    false,
                    {}
                )
            end,
        })

        vim.keymap.set("n", "-", require("lir.float").init)
        vim.keymap.set(
            "n",
            "<leader>vn",
            [[<CMD>execute 'edit ' .. expand('%:p:h')<CR>]]
        )
        vim.keymap.set(
            "n",
            "<leader>vl",
            [[<CMD>vsplit | vertical resize -12 | execute 'edit' .. expand('%:p:h')<CR>]]
        )

        vim.api.nvim_set_hl(0, "LirFloatBorder", { bg = "none" })
    end,
}
