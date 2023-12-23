return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "echasnovski/mini.statusline",
        enabled = false,
        config = function()
            vim.opt.showmode = false
            vim.opt.laststatus = 3

            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = vim.g.have_nerd_font })
            statusline.section_location = function()
                return "%2l:%-2v"
            end
            statusline.section_lsp = function()
                return ""
            end
            statusline.section_diagnostics = function()
                return ""
            end
        end
    },

    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        enabled = false,
        config = function()
            local devicons = require("nvim-web-devicons")
            local helpers = require("incline.helpers")
            require("incline").setup({
                window = { margin = { vertical = 0, horizontal = 0 } },
                hide = { cursorline = true },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
                        -- ft_icon and { ft_icon, guifg = ft_color } or "",
                        " ",
                        { filename, gui = modified and "bold,underline" or "" },
                        " ",
                        guibg = "#3c3960",
                    }
                end,
            })
        end
    },

    {
        "tamago324/lir.nvim",
        enabled = true,
        config = function()
            local actions = require'lir.actions'
            local mark_actions = require 'lir.mark.actions'
            local clipboard_actions = require'lir.clipboard.actions'

            require('lir').setup({
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

                mappings = {
                    ["<CR>"] = actions.edit,
                    ["o"] = actions.edit,
                    ["-"] = actions.up,
                    ['q'] = actions.quit,

                    ["d"] = actions.mkdir,
                    ["a"] = actions.newfile,
                    ["R"] = actions.rename,
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

            vim.keymap.set('n', '-', require('lir.float').init)
            vim.keymap.set('n', '<leader>vn', require('lir.float').toggle)
            vim.keymap.set('n', '<leader>vl', ':topleft vsplit | vertical resize -12 | edit .<cr>')
        end
    }
}
