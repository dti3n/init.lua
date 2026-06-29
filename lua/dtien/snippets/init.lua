local loader = require("dtien.snippets.loader")

local loaded = {
    global = {},
    by_ft = {},
}

local snip_module_path = function(x)
    return "dtien.snippets.lang." .. x
end

local function load_global()
    if #loaded.global > 0 then
        return loaded.global
    end
    local ok, snips = pcall(require, snip_module_path(loader.global))
    loaded.global = ok and snips or {}
    return loaded.global
end

local function load_for_ft(ft)
    if loaded.by_ft[ft] then
        return loaded.by_ft[ft]
    end

    local snips = vim.list_slice(load_global())
    for _, p in ipairs(loader.by_filetype[ft] or {}) do
        local ok, ft_snips = pcall(require, snip_module_path(p))
        if ok and type(ft_snips) == "table" then
            vim.list_extend(snips, ft_snips)
        end
    end

    loaded.by_ft[ft] = snips
    return snips
end

local function get_buf_snips()
    local ft = vim.bo.filetype
    return load_for_ft(ft)
end

local function find_snippet(before)
    local best_body, best_len = nil, 0
    for _, s in ipairs(get_buf_snips()) do
        local trig = s.trigger
        local len = #trig
        if len > best_len and before:sub(-len) == trig then
            local body = s.body
            if type(body) == "function" then
                body = body()
            end
            best_body, best_len = body, len
        end
    end
    return best_body, best_len
end

local function try_expand_snippet()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local before_cursor = line:sub(1, col)

    local body, trig_len = find_snippet(before_cursor)
    if not body then
        return false
    end

    vim.schedule(function()
        vim.api.nvim_buf_set_text(0, row - 1, col - trig_len, row - 1, col, {})
        vim.api.nvim_win_set_cursor(0, { row, col - trig_len })
        vim.snippet.expand(body)
    end)
    return true
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
        return
    end

    try_expand_snippet()
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
        return ""
    end
end, { expr = true })
