local function git_scratch(cmd, split_type)
    split_type = split_type or "left"
    if split_type == "below" then
        vim.cmd("new")
    else
        vim.cmd("leftabove vnew")
    end

    vim.bo.buftype = "nofile"
    vim.bo.swapfile = false
    vim.bo.bufhidden = "wipe"
    vim.bo.filetype = "git"
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(cmd))
end

local function refresh_git_status(bufnr)
    local lines = vim.fn.systemlist({ "git", "status", "-s" })
    if
        vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr)
    then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end
end

local function git_status_to_qf()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local qf_entries = {}
    for _, line in ipairs(lines) do
        local file = line:sub(4) -- strip status (first 3 chars)
        if file and file ~= "" then
            table.insert(qf_entries, { filename = file })
        end
    end

    if #qf_entries > 0 then
        vim.fn.setqflist({}, " ", {
            title = "Git Status",
            items = qf_entries,
        })
    else
        print("No files to add to quickfix")
    end
end

vim.keymap.set(
    "n",
    "<leader>gq",
    git_status_to_qf,
    { desc = "Git status → quickfix" }
)

vim.keymap.set("n", "<leader>gs", function()
    local full = vim.fn.systemlist({ "git", "status" })
    local short = vim.fn.systemlist({ "git", "status", "-s" })

    local lines = {}
    vim.list_extend(lines, short)
    table.insert(lines, "")
    table.insert(lines, "---")
    table.insert(lines, "")
    vim.list_extend(lines, full)

    vim.cmd("new")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.filetype = "gitstatus"
    vim.api.nvim_buf_set_name(0, "Git Status")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Git status --short" })

vim.keymap.set("n", "<leader>gl", function()
    git_scratch("git log --oneline")
end, { desc = "Git log" })

vim.keymap.set("n", "<leader>gL", function()
    git_scratch("git log --oneline " .. vim.fn.expand("%"))
end, { desc = "Git log current file" })

vim.keymap.set("n", "<leader>gb", function()
    git_scratch("git blame " .. vim.fn.expand("%"))
end, { desc = "Git blame file" })

vim.keymap.set("n", "<leader>go", function()
    local hash = vim.fn.expand("<cword>")
    if hash and #hash >= 7 then
        git_scratch("git show " .. hash)
    end
end, { desc = "Git open/show commit" })

vim.keymap.set("n", "<leader>ga", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_get_current_line()
    local file = line:sub(4) -- file starts after status chars
    local x, y = line:sub(1, 1), line:sub(2, 2) -- staged vs unstaged

    if x == " " and (y == "M" or y == "D") then
        vim.fn.system({ "git", "add", file })
        print("Staged: " .. file)
    elseif x == "M" or x == "A" or x == "D" then
        vim.fn.system({ "git", "restore", "--staged", file })
        print("Unstaged: " .. file)
    elseif line:match("^%?%?") then
        vim.fn.system({ "git", "add", file })
        print("Staged new: " .. file)
    else
        print("No action for: " .. line)
    end

    refresh_git_status(bufnr)
end, { desc = "Stage/unstage file under cursor" })
