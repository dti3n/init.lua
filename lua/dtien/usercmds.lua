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

-- usercmd("TrimTrailspace", function()
--     local curpos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd([[keeppatterns %s/\s\+$//e]])
--     vim.api.nvim_win_set_cursor(0, curpos)
-- end, { desc = "Highlight trailing whitespaces" })
--
-- usercmd("HlTrail", function()
--     vim.fn.matchadd("errorMsg", [[\s\+$]])
-- end, { desc = "Highlight trailing whitespaces" })
--
-- usercmd("NoHlTrail", function()
--     vim.fn.clearmatches()
-- end, { desc = "Clear highlighted trailing whitespaces" })
--
-- usercmd("FindAndReplace", function(opts)
--     vim.api.nvim_command(string.format("cdo s/%s/%s", opts.fargs[1], opts.fargs[2]))
--     vim.api.nvim_command("cfdo update")
-- end, { nargs = "*" })
