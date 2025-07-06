return {
    "stevearc/oil.nvim",
    enabled = false,
    lazy = false,
    config = function()
        CustomOilBar = function()
            local path = vim.fn.expand("%")
            path = path:gsub("oil://", "")
            return "  " .. vim.fn.fnamemodify(path, ":.")
        end

        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            lsp_file_methods = {
                enabled = true,
            },
            view_options = {
                show_hidden = true,
            },
            win_options = {
                winbar = "%{v:lua.CustomOilBar()}",
            },
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["\\t"] = { "actions.select", opts = { tab = true } },
                ["\\s"] = { "actions.change_sort", mode = "n" },
                ["\\x"] = "actions.open_external",
                ["\\."] = { "actions.toggle_hidden", mode = "n" },
            },
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>")
        vim.keymap.set("n", "<space>vn", oil.toggle_float)
    end,
}
