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
        run({ "git", "show", input .. ":" .. file }, "tabnew")
    end
end)
