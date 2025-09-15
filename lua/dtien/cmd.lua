local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local my_group = augroup("MyGroup", {})
local yank_group = augroup("HighlightYank", {})

usercmd("Nterm", "tabe | term", {})
usercmd("Vterm", "vsp | vertical resize -12 | term", {})
usercmd("Hterm", "sp | resize -8 | term", {})
usercmd("Bd", "up | %bd | e#", {}) -- delete all hidden buffers
usercmd("YankPathToClipboard", function()
    local file_path = vim.fn.expand("%:p")
    vim.fn.setreg("+", file_path)
    print("Yanked file path to clipboard: " .. file_path)
end, { desc = "Yank the full path of the current file to the clipboard" })

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})
