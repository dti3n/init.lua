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

local function find_snippet(trigger)
    for _, s in ipairs(get_buf_snips()) do
        if s.trigger == trigger then
            local body = s.body
            if type(body) == "function" then
                body = body()
            end
            return body
        end
    end
    return nil
end

local function try_expand_snippet()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    local before_cursor = line:sub(1, col)
    local trigger = before_cursor:match("(%S+)$")
    if not trigger then
        return false
    end

    local body = find_snippet(trigger)
    if not body then
        return false
    end

    vim.schedule(function()
        local new_line = before_cursor:sub(1, -#trigger - 1) .. line:sub(col + 1)
        vim.api.nvim_set_current_line(new_line)
        vim.api.nvim_win_set_cursor(0, { row, col - #trigger })
        vim.snippet.expand(body)
    end)

    return true
end

vim.keymap.set("i", "<C-k>", function()
    if try_expand_snippet() then
        return ""
    end

    if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
        return ""
    end

    return vim.api.nvim_replace_termcodes("<C-k>", true, true, true)
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-j>", function()
    if vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
        return ""
    end

    return vim.api.nvim_replace_termcodes("<C-j>", true, true, true)
end, { expr = true, silent = true })

vim.keymap.set({ "n", "i" }, "<C-x>", function()
    if vim.snippet.active() then
        vim.snippet.stop()
    end
end)
