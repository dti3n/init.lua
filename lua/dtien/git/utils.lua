local M = {}

M.in_git_repo = function()
    return vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")
end

M.make_buf_name = function(cmd)
    local cwd = vim.fn.getcwd()
    return string.format("git://%s//%s", cwd, table.concat(cmd, " "))
end

M.get_or_create_buf = function(name, open_cmd)
    local bufnr = vim.fn.bufnr(name)
    if bufnr ~= -1 then
        local winid = vim.fn.bufwinid(bufnr)
        if winid ~= -1 then
            vim.api.nvim_set_current_win(winid)
        else
            vim.cmd(open_cmd or "new")
            vim.api.nvim_win_set_buf(0, bufnr)
        end
        return bufnr
    end

    vim.cmd(open_cmd or "new")
    bufnr = vim.api.nvim_get_current_buf()

    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].bufhidden = "hide"
    vim.bo[bufnr].buflisted = false
    vim.bo[bufnr].swapfile = false
    vim.bo[bufnr].modified = false

    vim.api.nvim_buf_set_name(bufnr, name)
    return bufnr
end

M.set_filetype = function(bufnr, cmd)
    local joined = table.concat(cmd, " ")
    if joined:match("git show") and joined:match(":") then
        local file = joined:match(":(.+)$")
        if file then
            file = file:gsub("^['\"]", ""):gsub("['\"]$", "")
            vim.bo[bufnr].filetype = vim.filetype.match({ filename = file }) or "text"
            return
        end
    end

    if joined:match("git show") or joined:match("git diff") then
        vim.bo[bufnr].filetype = "diff"
    else
        vim.bo[bufnr].filetype = "git"
    end
end

return M
