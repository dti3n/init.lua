local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("TextYankPost", {
    group = augroup("dtien.highlight_yank", {}),
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

usercmd("JsonFormat", "%!jq .", {})

-- delete all hidden buffers
usercmd("Bd", function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("up | %bd | e#")
    vim.api.nvim_win_set_cursor(0, pos)
end, {})

usercmd("YankPath", function(opts)
    local kind = opts.args
    local file_path
    if kind == "t" then
        file_path = vim.fn.expand("%:t") -- tail: filename only
    elseif kind == "a" then
        file_path = vim.fn.expand("%:p") -- absolute path
    else
        file_path = vim.fn.expand("%:.") -- relative path
    end

    if file_path == "" then
        print("No file associated with this buffer")
        return
    end

    vim.fn.setreg("+", file_path)
    print("Yanked path: " .. file_path .. " to clipboard")
end, { nargs = "?" })
