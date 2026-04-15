local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local yank_group = augroup("HighlightYank", {})
local terminal_cursorline_group = augroup("TerminalCursorline", { clear = true })

usercmd("Nterm", "tabe | term", {})
usercmd("Vterm", "vsp | vertical resize -12 | term", {})
usercmd("Hterm", "sp | resize -8 | term", {})
usercmd("Bd", "up | %bd | e#", {}) -- delete all hidden buffers
usercmd("JsonPP", "%!jq .", {}) -- json pretty print
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

autocmd("TermOpen", {
    group = terminal_cursorline_group,
    callback = function(args)
        local bufnr = args.buf
        vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = bufnr,
            callback = function()
                vim.opt_local.cursorline = false
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })

        if vim.fn.mode() == "n" then
            vim.opt_local.cursorline = true
        else
            vim.opt_local.cursorline = false
        end
    end,
})
