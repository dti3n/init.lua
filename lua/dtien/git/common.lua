local utils = require("dtien.git.utils")

local M = {}

local function attach_mappings(bufnr, cmd)
    local joined = table.concat(cmd, " ")
    if joined:match("git log") or joined:match("git blame") then
        vim.keymap.set("n", "<CR>", function()
            local hash = vim.fn.expand("<cword>")
            if hash and hash:match("^%x+$") then
                M.run({ "git", "show", hash }, "tabnew")
            end
        end, { buffer = bufnr, silent = true, desc = "Git: show commit" })
    end
end

M.run = function(cmd, open_cmd)
    if not utils.in_git_repo() then
        vim.notify("Not in a git repository", vim.log.levels.ERROR)
        return
    end

    open_cmd = open_cmd or "new"

    local name = utils.make_buf_name(cmd)
    local bufnr = utils.get_or_create_buf(name, open_cmd)

    local output = vim.fn.systemlist(cmd)
    local exit_code = vim.v.shell_error
    if exit_code ~= 0 then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Git command failed:" })
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, output)
        return
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
    utils.set_filetype(bufnr, cmd)
    attach_mappings(bufnr, cmd)
end

return M
