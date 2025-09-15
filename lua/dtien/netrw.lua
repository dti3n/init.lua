-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.g.netrw_banner = 0
vim.g.netrw_altfile = 1
vim.g.netrw_winsize = 30
vim.g.netrw_hide = 0

vim.keymap.set("n", "-", ":Explore<cr>")
vim.keymap.set("n", "<leader>vl", function()
    local original_style = vim.g.netrw_liststyle or 0
    vim.g.netrw_liststyle = 3
    vim.cmd("vsplit | Explore")
    vim.g.netrw_liststyle = original_style
end)

local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
    pattern = "netrw",
    desc = "Better mappings for netrw",

    callback = function(desc)
        local bind = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true, silent = true })
        end

        -- edit new file
        bind("a", "%")

        -- open quickmap-help
        bind("?", ":help netrw-quickmap<CR>")

        -- -- open file
        -- bind("o", "<CR>")
    end,
})
