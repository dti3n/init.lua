if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = table.concat({
        "rg",
        "--vimgrep",
        "--smart-case",
        "--hidden",
        "--color=never",
        '--glob "!**/.git/*"',
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
    }, " ")
end

local function build_grep_cmd(pattern, opts)
    if not pattern or pattern == "" then
        return nil
    end

    local escaped = vim.fn.shellescape(pattern)
    local flag = opts and opts.literal and "-F" or ""

    return string.format("silent grep! %s %s", flag, escaped)
end

vim.keymap.set("n", "<leader>ps", function()
    vim.ui.input({ prompt = "ps > " }, function(pattern)
        local cmd = build_grep_cmd(pattern, { literal = true })
        if not cmd then
            return
        end
        vim.cmd(cmd)
        vim.cmd("copen")
    end)
end, { desc = "Project Search (literal)" })

vim.keymap.set("n", "<leader>pS", function()
    vim.ui.input({ prompt = "ps:regex > " }, function(pattern)
        local cmd = build_grep_cmd(pattern)
        if not cmd then
            return
        end
        vim.cmd(cmd)
        vim.cmd("copen")
    end)
end, { desc = "Project Search (regex)" })

vim.keymap.set("n", "<leader>bs", function()
    vim.ui.input({ prompt = "bs > " }, function(pattern)
        local base = build_grep_cmd(pattern, { literal = true })
        if not base then
            return
        end
        vim.cmd(base .. " %")
        vim.cmd("copen")
    end)
end, { desc = "Buffer Search (literal)" })

vim.keymap.set("n", "<leader>bS", function()
    vim.ui.input({ prompt = "bs:regex > " }, function(pattern)
        local base = build_grep_cmd(pattern)
        if not base then
            return
        end
        vim.cmd(base .. " %")
        vim.cmd("copen")
    end)
end, { desc = "Buffer Search (regex)" })
