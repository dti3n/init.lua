local common = require("dtien.git.common")
local status = require("dtien.git.status")

local run = common.run
local run_git_status = status.run_git_status

vim.keymap.set("n", "<leader>gs", run_git_status)

vim.keymap.set("n", "<leader>gS", function()
    run({ "git", "status" })
end)

vim.keymap.set("n", "<leader>gl", function()
    run({
        "git",
        "log",
        "-n100",
        "--pretty=format:%h%x09%an%x09%ad%x09%s",
    })
end)

vim.keymap.set({ "n", "v" }, "<leader>gL", function()
    local file = vim.fn.expand("%")
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV]") then
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")
        local start_line = math.min(start_pos[2], end_pos[2])
        local end_line = math.max(start_pos[2], end_pos[2])
        run({
            "git",
            "log",
            "-n100",
            "-L",
            string.format("%d,%d:%s", start_line, end_line, file),
        })
    else
        run({
            "git",
            "log",
            "-n100",
            "--pretty=format:%h%x09%an%x09%ad%x09%s",
            file,
        })
    end
end)

vim.keymap.set({ "n", "v" }, "<leader>gb", function()
    local file = vim.fn.expand("%")
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV]") then
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")
        local start_line = math.min(start_pos[2], end_pos[2])
        local end_line = math.max(start_pos[2], end_pos[2])
        run({ "git", "blame", "-L", string.format("%d,%d", start_line, end_line), file }, "tabnew")
    else
        run({ "git", "blame", file }, "tabnew")
    end
end)

vim.keymap.set("n", "<leader>gp", function()
    local file = vim.fn.expand("%")
    local input = vim.fn.input("git-preview > ")
    if input and input:match("^%x+$") then
        run({ "git", "show", input .. ":" .. file }, "vnew")
    end
end)

vim.keymap.set("n", "<leader>gh", function()
    local file = vim.fn.expand("%")
    if file == "" then
        vim.notify("No file open", vim.log.levels.WARN)
        return
    end

    local commits =
        vim.fn.systemlist({ "git", "log", "--oneline", "--pretty=format:%h%x09%an%x09%ad%x09%s", "--", file })
    if vim.v.shell_error ~= 0 or #commits == 0 then
        vim.notify("No git history for " .. file, vim.log.levels.WARN)
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, commits)
    vim.api.nvim_buf_set_name(buf, "git log --oneline -- " .. file)
    vim.bo[buf].bufhidden = "wipe"

    vim.cmd("new")
    vim.api.nvim_set_current_buf(buf)

    vim.keymap.set("n", "<CR>", function()
        local line_nr = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_get_current_line()
        local hash = line:match("^(%x+)")
        if not hash then
            return
        end

        local parent_line = commits[line_nr + 1]
        local parent = parent_line and parent_line:match("^(%x+)")
        if not parent then
            vim.notify("No previous commit for this file", vim.log.levels.WARN)
            return
        end

        local ft = vim.filetype.match({ filename = file }) or ""

        local left_lines = vim.fn.systemlist({ "git", "show", parent .. ":" .. file })
        local left_ok = vim.v.shell_error == 0

        local right_lines = vim.fn.systemlist({ "git", "show", hash .. ":" .. file })
        local right_ok = vim.v.shell_error == 0

        local left_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(left_buf, parent .. ":" .. file)
        vim.api.nvim_buf_set_lines(left_buf, 0, -1, false, left_ok and left_lines or {})
        vim.bo[left_buf].filetype = ft
        vim.bo[left_buf].bufhidden = "wipe"

        local right_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(right_buf, hash .. ":" .. file)
        vim.api.nvim_buf_set_lines(right_buf, 0, -1, false, right_ok and right_lines or {})
        vim.bo[right_buf].filetype = ft
        vim.bo[right_buf].bufhidden = "wipe"

        vim.cmd("tabnew")
        vim.api.nvim_set_current_buf(left_buf)
        vim.cmd("diffthis")
        vim.cmd("vsplit")
        vim.api.nvim_set_current_buf(right_buf)
        vim.cmd("diffthis")
    end, { buffer = buf, silent = true, desc = "Git: open diff" })
end, { desc = "Git: diff history" })
