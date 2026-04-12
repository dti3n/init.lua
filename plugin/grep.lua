if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = table.concat({
        "rg",
        "--vimgrep",
        "--smart-case",
        "--hidden",
        "--color=never",
        '--glob="!.git"',
        '--glob="!**/.git/**"',
        '--glob="!**/node_modules/**"',
        '--glob="!**/dist/**"',
        '--glob="!**/vendor/**"',
        '--glob="!*.log"',
    }, " ")
else
    vim.opt.grepprg = table.concat({
        "grep",
        "-HRIn",
        "$*",
        ".",
        "--exclude-dir=.git",
        "--exclude-dir=node_modules",
        "--exclude-dir=dist",
        "--exclude-dir=vendor",
        '--exclude="*.log"',
    }, " ")
end

local function build_grep_cmd(pattern)
    if not pattern or pattern == "" then
        return nil
    end

    local use_regex = false
    if pattern:sub(1, 1) == "/" then
        use_regex = true
        pattern = pattern:sub(2)
    end

    local escaped = vim.fn.shellescape(pattern)
    if use_regex then
        return "silent grep! " .. escaped
    else
        return "silent grep! -F " .. escaped
    end
end

-- project search
vim.keymap.set("n", "<leader>ps", function()
    vim.ui.input({ prompt = "project > " }, function(pattern)
        local cmd = build_grep_cmd(pattern)
        if not cmd then
            return
        end
        vim.cmd(cmd)
        vim.cmd("copen")
    end)
end, { desc = "Project Search" })

-- buffer search
vim.keymap.set("n", "<leader>bs", function()
    vim.ui.input({ prompt = "buffer > " }, function(pattern)
        local cmd = build_grep_cmd(pattern)
        if not cmd then
            return
        end

        vim.cmd(cmd)
        vim.cmd("copen")
    end)
end, { desc = "Buffer Search" })
