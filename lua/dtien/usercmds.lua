local usercmd = vim.api.nvim_create_user_command

usercmd("Nterm", "tabe | term", {})
usercmd("Vterm", "vsp | vertical resize -12 | term", {})
usercmd("Hterm", "sp | resize -8 | term", {})
usercmd("Bd", "up | %bd | e#", {}) -- delete all hidden buffers

usercmd("YankPathToClipboard", function()
    local file_path = vim.fn.expand("%:p")
    vim.fn.setreg("+", file_path)
    print("Yanked file path to clipboard: " .. file_path)
end, { desc = "Yank the full path of the current file to the clipboard" })
