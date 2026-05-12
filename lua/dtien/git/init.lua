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

vim.keymap.set("n", "<leader>gP", function()
    local file = vim.fn.expand("%")

    local handle = io.popen("git log -1 --format=%H -- " .. vim.fn.shellescape(file))
    if handle == nil then
        return
    end

    local latest_commit = handle:read("*a"):gsub("\n", "")
    handle:close()

    if latest_commit and latest_commit ~= "" then
        local handle2 = io.popen("git log -1 --format=%H " .. latest_commit .. "^ -- " .. vim.fn.shellescape(file))
        if handle2 == nil then
            return
        end

        local parent_commit = handle2:read("*a"):gsub("\n", "")
        handle2:close()

        if parent_commit and parent_commit ~= "" then
            vim.cmd("wincmd o")
            run({ "git", "show", parent_commit .. ":" .. file }, "leftabove vnew")
            vim.cmd("windo diffthis")
        else
            vim.notify("No previous commit found for this file", vim.log.levels.WARN)
        end
    end
end)
