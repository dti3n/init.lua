local files_cache = {}

local function FindCmd()
    if vim.fn.executable("fdfind") == 1 then
        return table.concat({
            "fdfind",
            "--type f",
            "--hidden",
            "--follow",
            "--color=never",
            "--exclude .git",
        }, " ")
    end

    if vim.fn.executable("fd") == 1 then
        return table.concat({
            "fd",
            "--type f",
            "--hidden",
            "--follow",
            "--color=never",
            "--exclude .git",
        }, " ")
    end

    if vim.fn.executable("rg") == 1 then
        return table.concat({
            "rg",
            "--files",
            "--hidden",
            "--color=never",
            '--glob "!**/.git/*"',
        }, " ")
    end

    if vim.fn.executable("find") == 1 then
        return table.concat({
            "find .",
            "-type f",
            '-not -path "*/.git/*"',
            '-not -path "*/node_modules/*"',
            '-not -path "*/dist/*"',
            '-not -path "*/vendor/*"',
        }, " ")
    end

    if vim.fn.executable("git") == 1 then
        return "git ls-files --cached --others --exclude-standard"
    end

    return ""
end

local function CustomFind(cmd_arg)
    if #files_cache == 0 then
        local cmd = FindCmd()
        if cmd == "" then
            -- fallback to native globpath
            files_cache = vim.fn.globpath(".", "**", true, true)
            files_cache = vim.tbl_filter(function(v)
                return vim.fn.isdirectory(v) == 0
            end, files_cache)
            files_cache = vim.tbl_map(function(v)
                return v:gsub("^%.[/\\]", "")
            end, files_cache)
        else
            files_cache = vim.fn.systemlist(cmd)
        end
    end

    if cmd_arg == nil or #cmd_arg == 0 then
        return files_cache
    else
        return vim.fn.matchfuzzy(files_cache, cmd_arg) or {}
    end
end

_G.CustomFind = CustomFind
vim.opt.findfunc = "v:lua.CustomFind"

-- autocommands for cmdline completion + cache reset
local augroup = vim.api.nvim_create_augroup
local cmd_autocomplete_group = augroup("CmdAutocompleteGroup", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = cmd_autocomplete_group,
    pattern = ":",
    callback = function()
        vim.opt.wildmode = "noselect:lastused,full"
        vim.opt.pumheight = 12
        files_cache = {}
    end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = cmd_autocomplete_group,
    pattern = ":",
    callback = function()
        vim.opt.wildmode = "full"
        vim.opt.pumheight = 0
    end,
})
vim.api.nvim_create_autocmd("CmdlineChanged", {
    group = cmd_autocomplete_group,
    pattern = ":",
    callback = function()
        local function should_enable_autocomplete()
            local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), " ")[1]
            return (cmdline_cmd == "find" or cmdline_cmd == "sf" or cmdline_cmd == "sfind")
        end
        if should_enable_autocomplete() then
            vim.fn.wildtrigger()
        end
    end,
})
