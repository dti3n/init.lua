local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local my_group = augroup("MyGroup", {})
local yank_group = augroup("HighlightYank", {})

usercmd("Nterm", "tabe | term", {})
usercmd("Vterm", "vsp | vertical resize -12 | term", {})
usercmd("Hterm", "sp | resize -8 | term", {})
usercmd("Bd", "up | %bd | e#", {}) -- delete all hidden buffers
usercmd("YankPath", function(opts)
    local kind = opts.args or "f"
    local file_path
    if kind == "r" then
        file_path = vim.fn.expand("%:.") -- relative path
    else
        file_path = vim.fn.expand("%:p") -- absolute path
    end

    if file_path == "" then
        print("No file associated with this buffer")
        return
    end

    vim.fn.setreg("+", file_path)
    print("Yanked path: " .. file_path .. " to clipboard")
end, {})

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
