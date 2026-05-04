local utils = require("dtien.git.utils")

local M = {}

local function status_char_from_line(line)
    return line:match("^%s*([MDAR?U])")
end

local function filepath_from_line(line)
    return line:match("^%s*[MDAR?U]%s+(.*)$")
end

local function is_staged_line(bufnr, row)
    for i = row - 1, 1, -1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
        if line:match("^Staged") then
            return true
        end
        if line:match("^Unstaged") then
            return false
        end
    end
    return false
end

local function attach_mappings(bufnr)
    vim.keymap.set({ "n", "v" }, "-", function()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

        if line == "Staged" then
            local result = vim.fn.system({ "git", "restore", "--staged", "--", ":/" })
            if vim.v.shell_error ~= 0 then
                vim.notify("Failed to unstage all:\n" .. result, vim.log.levels.ERROR)
            else
                vim.notify("unstaged all", vim.log.levels.INFO)
                M.run_git_status()
            end
            return
        end

        if line == "Unstaged" then
            local result = vim.fn.system({ "git", "add", "-A" })
            if vim.v.shell_error ~= 0 then
                vim.notify("Failed to stage all:\n" .. result, vim.log.levels.ERROR)
            else
                vim.notify("staged all", vim.log.levels.INFO)
                M.run_git_status()
            end
            return
        end

        local status_char = status_char_from_line(line)
        local filepath = filepath_from_line(line)
        if not status_char or not filepath then
            return
        end

        local is_staged = is_staged_line(bufnr, row)
        local old = line:match("^%s*[MDAR?U]%s+(.-)%s+->")
        local new = line:match("->%s*(.+)$")
        local git_cmd
        if is_staged then
            if status_char == "R" and old and new then
                git_cmd = { "git", "restore", "--staged", "--", old, new }
            else
                git_cmd = { "git", "restore", "--staged", "--", filepath }
            end
        else
            git_cmd = { "git", "add", "--", filepath }
        end

        local result = vim.fn.system(git_cmd)
        if vim.v.shell_error ~= 0 then
            vim.notify("Failed:\n" .. result, vim.log.levels.ERROR)
        else
            vim.notify(filepath .. (is_staged and " -> unstaged" or " -> staged"), vim.log.levels.INFO)
            M.run_git_status()
        end
    end, { buffer = bufnr, silent = true, desc = "Git: stage/unstage" })

    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_get_current_line()
        local filepath = filepath_from_line(line)
        if filepath then
            vim.cmd("wincmd p")
            vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        end
    end, { buffer = bufnr, silent = true, desc = "Git: edit file" })

    vim.keymap.set("n", "=", function()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_get_current_line()
        local filepath = filepath_from_line(line)
        local is_staged = is_staged_line(bufnr, row)
        local cmd = is_staged and { "git", "diff", "--cached", filepath } or { "git", "diff", filepath }
        if filepath then
            require("dtien.git.common").run(cmd, "tabnew")
        end
    end, { buffer = bufnr, silent = true, desc = "Git: diff file" })

    vim.keymap.set("n", "cc", function()
        vim.cmd("terminal git commit")
        vim.cmd("startinsert")
    end, { buffer = bufnr, silent = true, desc = "Git: commit" })

    -- vim.keymap.set("n", "cva", function()
    --     vim.cmd("terminal git commit --amend")
    --     vim.cmd("startinsert")
    -- end, { buffer = bufnr, silent = true, desc = "Git: commit --amend" })
    --
    -- vim.keymap.set("n", "ce", function()
    --     vim.cmd("terminal git commit --amend --no-edit")
    --     vim.cmd("startinsert")
    -- end, { buffer = bufnr, silent = true, desc = "Git: commit --amend --no-edit" })
end

local function build_buf_lines(staged, unstaged)
    local lines = {}

    local branch = vim.fn.systemlist("git branch --show-current")[1] or ""
    table.insert(lines, "[" .. branch .. "]")

    table.insert(lines, "")
    table.insert(lines, "Staged")

    if #staged == 0 then
        table.insert(lines, "(none)")
    else
        for _, f in ipairs(staged) do
            if f.status == "R" and f.old and f.new then
                table.insert(lines, f.status .. " " .. f.old .. " -> " .. f.new)
            else
                table.insert(lines, f.status .. " " .. f.new)
            end
        end
    end

    table.insert(lines, "")
    table.insert(lines, "Unstaged")

    if #unstaged == 0 then
        table.insert(lines, "(none)")
    else
        for _, f in ipairs(unstaged) do
            if f.status == "R" and f.old and f.new then
                table.insert(lines, f.status .. " " .. f.old .. " -> " .. f.new)
            else
                table.insert(lines, f.status .. " " .. f.new)
            end
        end
    end

    return lines
end

M.run_git_status = function()
    if not utils.in_git_repo() then
        vim.notify("Not in a git repository", vim.log.levels.ERROR)
        return
    end

    local name = utils.make_buf_name({ "git", "status" })
    local bufnr = utils.get_or_create_buf(name, "new")

    local status_out = vim.fn.systemlist("git status --short")
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Git status failed:" })
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, status_out)
        return
    end

    local staged, unstaged = {}, {}

    for _, line in ipairs(status_out) do
        local x = line:sub(1, 1)
        local y = line:sub(2, 2)

        local old_path, new_path
        if line:find("->") then
            old_path = line:match("^.. (.-) %->")
            new_path = line:match("%-> (.+)$")
        else
            new_path = line:sub(4)
        end

        if x ~= " " and x ~= "?" then
            table.insert(staged, { status = x, old = old_path, new = new_path })
        end

        if y ~= " " then
            if x == "?" and y == "?" then
                table.insert(unstaged, { status = "?", new = new_path })
            else
                table.insert(unstaged, { status = y, old = old_path, new = new_path })
            end
        end
    end

    local lines = build_buf_lines(staged, unstaged)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.bo[bufnr].modified = false
    attach_mappings(bufnr)
end

return M
