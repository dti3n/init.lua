-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1

vim.g.netrw_banner = 0
vim.g.netrw_altfile = 1
vim.g.netrw_winsize = 30

vim.keymap.set("n", "<leader>vn", ":Explore<cr>")
vim.keymap.set("n", "<leader>vl", ":Lexplore %:p:h<cr>")

-- these remaps feel pretty good to use
-- open file with o and add file with a
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
    pattern = 'netrw',
    desc = 'Better mappings for netrw',

    callback = function(desc)
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true, silent = true })
        end

        -- edit new file
        bind('a', '%')

        -- open file
        bind('o', '<CR>')
    end
})
