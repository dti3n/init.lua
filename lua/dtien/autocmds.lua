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
    -- command = "startinsert | set cursorline",
    command = "set cursorline",
})

autocmd("BufEnter", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end })

autocmd("BufEnter", {
    pattern = { "*.erb", "*.eruby" },
    -- command = "set filetype=html | set syntax=html",
    command = "set filetype=html",
})

