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
        vim.cmd("copen")
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
    local output = vim.fn.systemlist({ "git", "status", "-s" })
    local lines = {}
    vim.list_extend(lines, output)
    vim.cmd("new")
    vim.cmd("resize 10")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.filetype = "gitstatus"
    vim.api.nvim_buf_set_name(0, "Git Status")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Git status --short" })

vim.keymap.set("n", "<leader>go", function()
    local hash = vim.fn.expand("<cword>")
    if hash and #hash >= 7 then
        git_scratch("git show " .. hash)
    end
end, { desc = "Git open/show commit" })

vim.api.nvim_create_user_command("Git", function(opts)
    local args = vim.split(opts.args, "%s+", { trimempty = true })
    local subcmd = args[1] and args[1]:lower() or ""

    if subcmd == "blame" then
        git_scratch("git blame " .. vim.fn.expand("%"))
    elseif subcmd == "status" then
        local cmd = "git status"
        if #args > 1 then
            local processed_args = vim.tbl_map(function(arg)
                return arg == "%" and vim.fn.expand("%") or arg
            end, args)
            cmd = cmd .. " " .. table.concat(processed_args, " ", 2)
        end
        git_scratch(cmd, "below")
    elseif subcmd == "log" then
        local cmd = "git log"
        if #args > 1 then
            local processed_args = vim.tbl_map(function(arg)
                return arg == "%" and vim.fn.expand("%") or arg
            end, args)
            cmd = cmd .. " " .. table.concat(processed_args, " ", 2)
        end
        git_scratch(cmd, "below")
    else
        print("Unknown Git subcommand: " .. subcmd)
    end
end, { nargs = "*" })
