local function git_scratch(cmd, split_type)
    vim.cmd("new")
    vim.bo.buftype = "nofile"
    vim.bo.swapfile = false
    vim.bo.bufhidden = "wipe"
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(cmd))
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

vim.keymap.set("n", "<leader>gL", function()
    git_scratch("git log --oneline ")
end, { desc = "Git log --oneline" })

vim.keymap.set("n", "<leader>gb", function()
    git_scratch("git blame " .. vim.fn.expand("%"))
end, { desc = "Git blame file" })

vim.keymap.set("n", "<leader>go", function()
    local hash = vim.fn.expand("<cword>")
    if hash and #hash >= 7 then
        git_scratch("git show " .. hash)
    end
end, { desc = "Git open/show commit" })
