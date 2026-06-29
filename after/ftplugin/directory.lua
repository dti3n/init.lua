vim.opt_local.winbar = "[dir] %f"
vim.opt_local.colorcolumn = ""

local function find_buf(path)
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(bufnr) == path then
            return bufnr
        end
    end
    return -1
end

vim.keymap.set("n", "a", ":edit %/", { buffer = true, remap = true })

vim.keymap.set("n", "m", function()
    local name = vim.fn.expand("<cfile>")
    if name == "" then
        return
    end

    local full_path = vim.fn.expand("%:p:h") .. "/" .. name
    local is_dir = vim.fn.isdirectory(full_path) == 1

    local escaped = vim.fn.shellescape(full_path)
    local left = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
    vim.fn.feedkeys(":!mv " .. escaped .. " " .. escaped .. left:rep(is_dir and 2 or 1), "n")
end, { buffer = true, remap = true })

vim.keymap.set("n", "d", function()
    local ok, dir_name = pcall(vim.fn.input, "Directory name: ")
    if not ok or dir_name == "" then
        return
    end

    local full_path = vim.fn.expand("%:p:h") .. "/" .. dir_name
    local result = vim.fn.system("mkdir " .. vim.fn.shellescape(full_path))
    if vim.v.shell_error ~= 0 then
        vim.notify("mkdir failed: " .. result, vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(nvim-dir-reload)", true, false, true), "m", false)
end, { buffer = true, remap = true })

vim.keymap.set("n", "D", function()
    local name = vim.fn.expand("<cfile>")
    if name == "" then
        return
    end

    local full_path = vim.fn.expand("%:p:h") .. "/" .. name
    local escaped = vim.fn.shellescape(full_path)
    local cmd = vim.fn.isdirectory(full_path) == 1 and "rm -rd " .. escaped or "rm " .. escaped

    local ok, confirm = pcall(vim.fn.input, "Delete " .. name .. " ? [" .. cmd .. "]" .. " [y/N] ")
    if not ok or confirm:lower() ~= "y" then
        return
    end

    if vim.fn.isdirectory(full_path) ~= 1 then
        local bufnr = find_buf(full_path)
        if bufnr ~= -1 and vim.api.nvim_buf_is_loaded(bufnr) then
            vim.cmd("bdelete! " .. bufnr)
        end
    end

    local result = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
        vim.notify("rm failed: " .. result, vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(nvim-dir-reload)", true, false, true), "m", false)
end, { buffer = true, remap = true })
