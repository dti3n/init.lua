local state = {
    win = nil,
    buf = nil,
}

local function bookmark_file()
    local cwd = vim.loop.cwd()
    local foldername = vim.fn.fnamemodify(cwd, ":t")
    local unique_id = foldername .. "_" .. vim.fn.sha256(cwd):sub(1, 8)
    return vim.fn.stdpath("state") .. "/bookmarks/" .. unique_id .. ".json"
end

local function read_file()
    local path = bookmark_file()
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local content = f:read("*a")
    f:close()
    return content
end

local function write_file(content)
    local path = bookmark_file()
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    local f = io.open(path, "w")
    if not f then
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
    if ok then
        write_file(encoded)
    end
end

local function add()
    local file = vim.fn.expand("%:p")
    if file == "" then
        return
    end
    local cache = load()
    for _, bm in ipairs(cache) do
        if bm.file == file then
            -- update the line/col if re-add
            bm.line = vim.fn.line(".")
            bm.col = vim.fn.col(".")
            save(cache)
            vim.notify("Added bookmark: " .. vim.fn.fnamemodify(file, ":."), vim.log.levels.INFO)
            return
        end
    end
    table.insert(cache, {
        file = file,
        line = vim.fn.line("."),
        col = vim.fn.col("."),
    })
    save(cache)
    vim.notify("Added bookmark: " .. vim.fn.fnamemodify(file, ":."), vim.log.levels.INFO)
end

local function delete(index)
    local idx = tonumber(index)
    if not idx then
        vim.notify("Invalid bookmark index: " .. tostring(index), vim.log.levels.WARN)
        return
    end

    local cache = load()
    if idx < 1 or idx > #cache then
        vim.notify("No bookmark at index " .. idx, vim.log.levels.WARN)
        return
    end

    local removed = cache[idx].file or "<unknown>"
    table.remove(cache, idx)
    save(cache)
    vim.notify("Removed bookmark: " .. removed, vim.log.levels.INFO)
end

local function toggle()
    local file = vim.fn.expand("%:p")
    if file == "" then
        return
    end
    local cache = load()
    for i, bm in ipairs(cache) do
        if bm.file == file then
            delete(i)
            return
        end
    end
    add()
end

local function list()
    local cache = load()
    local files = {}
    if #cache == 0 then
        vim.notify("No bookmarks found", vim.log.levels.INFO)
        return files
    end
    for i, bm in ipairs(cache) do
        table.insert(files, string.format("%d. %s", i, vim.fn.fnamemodify(bm.file, ":.")))
    end
    return files
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
        local l = bm.line or 0
        local c = bm.col and bm.col - 1 or 0
        vim.api.nvim_win_set_cursor(0, { l, c })
        vim.cmd("normal! zz")
    end
end

local function clear()
    save({})
    vim.notify("Cleared all bookmarks for this project", vim.log.levels.INFO)
end

local function edit()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        state.buf = nil
        return
    end

    local cache = load()
    local buf_name = "Project Bookmarks"
    local buf = vim.fn.bufnr(buf_name)
    if buf ~= -1 then
        vim.api.nvim_buf_delete(buf, { force = true })
    end

    -- set buf
    buf = vim.api.nvim_create_buf(false, true)
    state.buf = buf
    local lines = {}
    for _, bm in ipairs(cache) do
        local fname = vim.fn.fnamemodify(bm.file, ":.") -- relative path
        local l = bm.line or 0
        local c = bm.col or 0
        table.insert(lines, string.format("%s %d:%d", fname, l, c))
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- set win
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.4)
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

    -- set options
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].filetype = "projectbookmarks"
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = "wipe"
    vim.wo[win].number = true

    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_get_current_line()
        local path, line_num, col_num = line:match("^(.-)%s+(%d+):(%d+)$")
        if path and line_num and col_num then
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            state.win = nil
            state.buf = nil
            vim.cmd("edit " .. vim.fn.fnameescape(path))
            local ok = pcall(vim.api.nvim_win_set_cursor, 0, {
                tonumber(line_num),
                tonumber(col_num) - 1,
            })
            if ok then
                vim.cmd("normal! zz")
            end
        else
            vim.notify("Invalid bookmark format: " .. line, vim.log.levels.WARN)
        end
    end, { buffer = buf, noremap = true, silent = true })

    -- q / :w to close
    for _, key in ipairs({ "q", ":w" }) do
        vim.keymap.set("n", key, function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            state.win = nil
            state.buf = nil
        end, { buffer = buf, noremap = true, silent = true })
    end

    -- autosave when buffer is closed
    vim.api.nvim_create_autocmd("BufWipeout", {
        buffer = buf,
        callback = function()
            local new_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            local new_cache = {}
            for _, line in ipairs(new_lines) do
                local path, line_num, col_num = line:match("^(.-)%s+(%d+):(%d+)$")
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
