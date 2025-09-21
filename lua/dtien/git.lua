local function git_scratch(cmd)
    vim.cmd("new")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].swapfile = false
    vim.bo[bufnr].bufhidden = "wipe"
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.systemlist(cmd))
    if cmd:match("git show") or cmd:match("git diff") then
        filetype = "diff"
    else
        filetype = "git"
    end
    vim.bo[bufnr].filetype = filetype
end

vim.keymap.set("n", "<leader>gs", function()
    local output = vim.fn.systemlist({ "git", "status", "-s" })
    git_scratch("git status")
end, { desc = "Git status" })

vim.keymap.set("n", "<leader>gS", function()
    git_scratch("git status --short")
end, { desc = "Git status --short" })

vim.keymap.set("n", "<leader>gl", function()
    git_scratch("git log")
end, { desc = "Git log" })

vim.keymap.set({ "n", "v" }, "<leader>gL", function()
    local file = vim.fn.expand("%")
    local cmd = "git log --oneline " .. file
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV]") then
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        cmd = string.format("git log -L %d,%d:%s", start_line, end_line, file)
    end
    git_scratch(cmd, "new", "git")
end, { desc = "Git log (normal: --oneline, visual: -L selected lines)" })

vim.keymap.set({ "n", "v" }, "<leader>gb", function()
    local cmd = "git blame " .. vim.fn.expand("%")
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV]") then
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        local file = vim.fn.expand("%")
        cmd = string.format("git blame -L %d,%d %s", start_line, end_line, file)
    end
    git_scratch(cmd)
end, { desc = "Git blame (normal: full file, visual: -L selected lines)" })

vim.keymap.set("n", "<leader>go", function()
    local hash = vim.fn.expand("<cword>")
    if hash and #hash >= 7 then
        git_scratch("git show " .. hash)
    end
end, { desc = "Git open/show commit" })
