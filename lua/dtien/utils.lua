local lang_maps = {
    cpp = { build = "g++ % -o %:r", exec = "./%:r" },
    java = { build = "javac %", exec = "java %:r" },
    go = { build = "go build", exec = "go run %" },
    typescript = { exec = "tsc" },
    javascript = { exec = "node %" },
    python = { exec = "python3 %" },
    rust = { exec = "cargo run" },
}

for lang, data in pairs(lang_maps) do
    if data.build ~= nil then
        vim.api.nvim_create_autocmd(
            "FileType",
            { command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
        )
    end

    vim.api.nvim_create_autocmd(
        "FileType",
        { command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
    )
end

-------------------------------------------------

-- vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
-- vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber", pattern = "*" })

vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" }
    end
})

vim.api.nvim_create_user_command('Nterm', 'tabe | term', {})
vim.api.nvim_create_user_command('Vterm', 'vsp | vertical resize -21 | term', {})
vim.api.nvim_create_user_command('Hterm', 'sp | resize -6 | term', {})
vim.api.nvim_create_user_command('Bd', 'up | %bd | e#', {}) -- delete all hidden buffers

-------------------------------------------------

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

autocmd('FileType', {
    pattern = 'netrw',
    desc = 'Better mappings for netrw',

    callback = function(desc)
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
        end

        -- edit new file
        bind('a', '%')

        -- rename file
        bind('r', 'R')

        -- open file
        bind('o', '<CR>')
    end
})
