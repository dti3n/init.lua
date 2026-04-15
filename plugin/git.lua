local run
local attach_mappings

local function in_git_repo()
    return vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")
end

local function make_buf_name(cmd)
    local cwd = vim.fn.getcwd()
    return string.format("git://%s//%s", cwd, table.concat(cmd, " "))
end

local function get_or_create_buf(name, open_cmd)
    local bufnr = vim.fn.bufnr(name)
    if bufnr ~= -1 then
        vim.api.nvim_set_current_buf(bufnr)
        return bufnr
    end

    vim.cmd(open_cmd or "new")
    bufnr = vim.api.nvim_get_current_buf()

    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].buflisted = false
    vim.bo[bufnr].swapfile = false

    vim.api.nvim_buf_set_name(bufnr, name)

    return bufnr
end

local function set_filetype(bufnr, cmd)
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

attach_mappings = function(bufnr, cmd)
    if table.concat(cmd, " "):match("git log") then
        vim.keymap.set("n", "<CR>", function()
            local hash = vim.fn.expand("<cword>")
            if hash and hash:match("^%x+$") then
                run({ "git", "show", hash }, "tabnew")
            end
        end, { buffer = bufnr, silent = true })
    end

    if table.concat(cmd, " "):match("git status") then
        vim.keymap.set("n", "=", function()
            local filepath = vim.fn.expand("<cfile>")
            if filepath then
                run({ "git", "diff", filepath }, "tabnew")
            end
        end, { buffer = bufnr, silent = true })
        vim.keymap.set("n", "<CR>", function()
            local filepath = vim.fn.expand("<cfile>")
            if filepath then
                vim.cmd("tabedit " .. vim.fn.fnameescape(filepath))
            end
        end, { buffer = bufnr, silent = true })
    end
end

run = function(cmd, open_cmd)
    if not in_git_repo() then
        vim.notify("Not in a git repository", vim.log.levels.ERROR)
        return
    end

    open_cmd = open_cmd or "new"

    local name = make_buf_name(cmd)
    local bufnr = get_or_create_buf(name, open_cmd)

    local output = vim.fn.systemlist(cmd)
    local exit_code = vim.v.shell_error
    if exit_code ~= 0 then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
            "Git command failed:",
        })
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, output)
        return
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)

    set_filetype(bufnr, cmd)
    attach_mappings(bufnr, cmd)
end

vim.keymap.set("n", "<leader>gs", function()
    run({ "git", "status" })
end)

vim.keymap.set("n", "<leader>gS", function()
    run({ "git", "status", "--short" })
end)

vim.keymap.set("n", "<leader>gl", function()
    run({
        "git",
        "log",
        "--pretty=format:%h%x09%an%x09%ad%x09%s",
    })
end)

vim.keymap.set({ "n", "v" }, "<leader>gL", function()
    local file = vim.fn.expand("%")
    local mode = vim.api.nvim_get_mode().mode

    if mode:match("[vV]") then
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        run({ "git", "log", "-L", string.format("%d,%d:%s", start_line, end_line, file) })
    else
        run({
            "git",
            "log",
            "--pretty=format:%h%x09%an%x09%ad%x09%s",
            file,
        })
    end
end)

vim.keymap.set({ "n", "v" }, "<leader>gb", function()
    local file = vim.fn.expand("%")
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV]") then
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        run({ "git", "blame", "-L", string.format("%d,%d", start_line, end_line), file }, "tabnew")
    else
        run({ "git", "blame", file }, "tabnew")
    end
end)

vim.keymap.set("n", "<leader>gp", function()
    local file = vim.fn.expand("%")
    local input = vim.fn.input("git-preview > ")
    if input == "" then
        return
    end
    run({ "git", "show", input .. ":" .. file }, "tabnew")
end)
