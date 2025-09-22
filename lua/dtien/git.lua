local function git_scratch(git_cmd, cmd)
    if cmd == nil then
        cmd = "new"
    end
    vim.cmd(cmd)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].swapfile = false
    vim.bo[bufnr].bufhidden = "wipe"
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.systemlist(git_cmd, cmd))
    if git_cmd:match("git show .*:") then
        local file = git_cmd:match(".*:'(.*)'$")
        filetype = vim.filetype.match({ filename = file }) or "text"
    elseif cmd:match("git show") or cmd:match("git diff") then
        filetype = "diff"
    else
        filetype = "git"
    end
    vim.bo[bufnr].filetype = filetype
    vim.api.nvim_buf_set_name(0, git_cmd)
end

vim.keymap.set("n", "<leader>gs", function()
    git_scratch("git status")
end, { desc = "Git status" })

vim.keymap.set("n", "<leader>gS", function()
    git_scratch("git status --short")
end, { desc = "Git status --short" })

vim.keymap.set("n", "<leader>gl", function()
    git_scratch("git log --pretty=format:'%h%x09%an%x09%ad%x09%s'")
end, { desc = "Git log" })

vim.keymap.set({ "n", "v" }, "<leader>gL", function()
    local file = vim.fn.expand("%")
    local cmd = "git log --pretty=format:'%h%x09%an%x09%ad%x09%s' " .. file
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
    git_scratch(cmd, "tabnew")
end, { desc = "Git blame (normal: full file, visual: -L selected lines)" })

vim.keymap.set("n", "<leader>go", function()
    local hash = vim.fn.expand("<cword>")
    if hash and #hash >= 7 then
        git_scratch("git show " .. hash, "tabnew")
    end
end, { desc = "Git open/show commit" })

vim.keymap.set("n", "<leader>gp", function()
    local repo_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
    if vim.v.shell_error ~= 0 then
        vim.notify("Not in a git repository", vim.log.levels.ERROR)
        return
    end

    local file = vim.fn.expand("%")
    local relative_file = file
    if file ~= "" and vim.fn.filereadable(file) == 1 then
        local abs_file = vim.fn.fnamemodify(file, ":p")
        relative_file = vim.fn.substitute(abs_file, repo_root .. "/", "", "")
    end

    local ok, input = pcall(vim.fn.input, "git-preview > ")
    if not ok or input == "" then
        return
    end

    git_scratch(string.format("git show %s:%s", input, vim.fn.shellescape(relative_file)), "tabnew")
end, { desc = "Git preview commit" })
