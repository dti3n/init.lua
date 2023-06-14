local augroup = vim.api.nvim_create_augroup
MyGroup = augroup('', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = MyGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert | set cursorline",
})

autocmd("BufEnter", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end })

autocmd("FileType", {
    pattern = 'netrw',
    desc = 'Better mappings for netrw',

    callback = function(desc)
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true, silent = true })
        end

        -- edit new file
        bind('a', '%')

        -- rename file
        bind('r', 'R')

        -- open file
        bind('o', '<CR>')

        -- quit netrw
        bind('q', vim.cmd.bd)
    end
})

