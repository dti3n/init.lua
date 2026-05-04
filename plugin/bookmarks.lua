local state = {
    win = nil,
    buf = nil,
}

local settings = {
    bookmark_branch = true,
}

local MARK_REGEX = "^(%-?%d+):(%-?%d+):(.-)$"

local function project_key()
    local cwd = vim.fn.getcwd()
    local foldername = vim.fn.fnamemodify(cwd, ":t")
    local id = vim.fn.sha256(cwd):sub(1, 8)
    return id .. "-" .. foldername
end

local function branch_key()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("%s+$", "")
    if branch ~= "" and branch ~= "HEAD" then
        return project_key() .. "-" .. branch
    end
    return project_key()
end

local function bookmarks_file()
    local key = settings.bookmark_branch and branch_key() or project_key()
    local bookmarks_dir = vim.fn.stdpath("state") .. "/bookmarks"
    return bookmarks_dir .. "/" .. key .. ".json"
end

local function read_file()
    local path = bookmarks_file()
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local content = f:read("*a")
    f:close()
    return content
end

local function write_file(content)
    local path = bookmarks_file()
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    local f = io.open(path, "w")
    if not f then
        vim.notify("Failed to write bookmarks", vim.log.levels.ERROR)
        return false
    end
    f:write(content)
    f:close()
    return true
end

local function load()
    local content = read_file()
    if not content then
        return {}
    end
    local ok, decoded = pcall(vim.json.decode, content)
    if ok and type(decoded) == "table" then
        return decoded
    end
    return {}
end

local function save(cache)
    local ok, encoded = pcall(vim.json.encode, cache)
    if ok and #cache > 0 then
        write_file(encoded)
    end
end

local function add()
    local file = vim.fn.expand("%:p")
    if file == "" then
        vim.notify("No file to bookmark", vim.log.levels.WARN)
        return
    end

    local l = vim.fn.line(".")
    local c = vim.fn.col(".")

    local cache = load()
    for _, bm in ipairs(cache) do
        if bm.file == file then
            if bm.line ~= l or bm.col ~= c then
                bm.line = l
                bm.col = c
                save(cache)
                vim.notify("Updated bookmark: " .. vim.fn.fnamemodify(file, ":."), vim.log.levels.INFO)
            end
            return
        end
    end

    table.insert(cache, {
        file = file,
        line = l,
        col = c,
    })

    save(cache)
    vim.notify("Added bookmark: " .. vim.fn.fnamemodify(file, ":."), vim.log.levels.INFO)
end

local function open(index)
    local cache = load()
    local bm = cache[index]
    if not bm then
        vim.notify("Bookmark not set", vim.log.levels.WARN)
        return
    end
    vim.cmd("edit " .. vim.fn.fnameescape(bm.file))
    if bm.line and bm.line > 0 then
        local ok = pcall(vim.api.nvim_win_set_cursor, 0, { bm.line, math.max(0, bm.col - 1) })
        if ok then
            vim.cmd("normal! zz")
        end
    end
end

local function clear()
    save({})
    vim.notify("Cleared all bookmarks", vim.log.levels.INFO)
end

local function format_bookmark(bm)
    local fname = vim.fn.fnamemodify(bm.file, ":.")
    return string.format("%d:%d:%s", bm.line or 0, bm.col or 0, fname)
end

local function edit()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        state.buf = nil
        return
    end

    local cache = load()

    local buf = vim.api.nvim_create_buf(false, true)
    state.buf = buf

    local lines = {}
    for _, bm in ipairs(cache) do
        table.insert(lines, format_bookmark(bm))
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.5)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "single",
    })
    state.win = win

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].filetype = "projectbookmarks"
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = "wipe"
    vim.wo[win].number = true
    vim.wo[win].wrap = true

    local function close_window()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        state.win = nil
        state.buf = nil
    end

    vim.keymap.set("n", "<CR>", function()
        -- local index = vim.fn.line(".")
        -- close_window()
        -- open(index)
        local line = vim.api.nvim_get_current_line()
        local line_num, col_num, path = line:match(MARK_REGEX)
        if path and line_num and col_num then
            close_window()
            vim.cmd("edit " .. vim.fn.fnameescape(path))
            local ok = pcall(vim.api.nvim_win_set_cursor, 0, {
                tonumber(line_num),
                math.max(0, tonumber(col_num) - 1),
            })
            if ok then
                vim.cmd("normal! zz")
            end
        else
            vim.notify("Invalid bookmark format", vim.log.levels.WARN)
        end
    end, { buffer = buf, noremap = true, silent = true })

    vim.keymap.set("n", "q", close_window, { buffer = buf, noremap = true, silent = true })

    vim.api.nvim_create_autocmd("BufWipeout", {
        buffer = buf,
        callback = function()
            local new_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            local new_cache = {}
            for _, line in ipairs(new_lines) do
                local line_num, col_num, path = line:match(MARK_REGEX)
                if path and path ~= "" then
                    local abs_path = vim.fn.fnamemodify(path, ":p")
                    table.insert(new_cache, {
                        file = abs_path,
                        line = tonumber(line_num) or 0,
                        col = tonumber(col_num) or 0,
                    })
                end
            end
            save(new_cache)
        end,
    })
end

vim.api.nvim_create_user_command("Bookmarks", edit, {})
vim.api.nvim_create_user_command("ClearBookmarks", clear, {})

vim.keymap.set("n", "<C-e>", edit, { desc = "toggle bookmarks" })
vim.keymap.set("n", "<leader>m", add, { desc = "add bookmark" })
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        open(i)
    end, { desc = "Go to bookmark " .. i })
end
