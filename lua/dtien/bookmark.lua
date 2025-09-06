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
            vim.notify("Already bookmarked", vim.log.levels.INFO)
            return
        end
    end
    table.insert(cache, {
        file = file,
        line = vim.fn.line("."),
    })
    save(cache)
    vim.notify(
        "Added bookmark: " .. vim.fn.fnamemodify(file, ":."),
        vim.log.levels.INFO
    )
end

local function delete(index)
    local idx = tonumber(index)
    if not idx then
        vim.notify(
            "Invalid bookmark index: " .. tostring(index),
            vim.log.levels.WARN
        )
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
        table.insert(
            files,
            string.format("%d. %s", i, vim.fn.fnamemodify(bm.file, ":."))
        )
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
        vim.api.nvim_win_set_cursor(0, { bm.line, 0 })
        vim.cmd("normal! zz")
    end
end

local function clear()
    save({})
    vim.notify("Cleared all bookmarks for this project", vim.log.levels.INFO)
end

-- Commands
vim.api.nvim_create_user_command("Bookmarks", function()
    print(table.concat(list(), "\n"))
end, {})

vim.api.nvim_create_user_command("AddBookmark", function()
    add()
end, {})

vim.api.nvim_create_user_command("DelBookmark", function(opts)
    delete(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("ClearBookmarks", function()
    clear()
end, {})

-- Keymaps
vim.keymap.set("n", "<leader>m", toggle, { desc = "Toggle bookmark" })

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        open(i)
    end, { desc = "Go to bookmark " .. i })
end
