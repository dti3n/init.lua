-- need to put this at top
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("dtien.plugins", {
    change_detection = {
        enabled = false,
        notify = false,
    },
    -- ui = {
    --     icons = {
    --         cmd = "⌘",
    --         config = "🛠",
    --         event = "📅",
    --         ft = "📂",
    --         init = "⚙",
    --         keys = "🗝",
    --         plugin = "🔌",
    --         runtime = "💻",
    --         source = "📄",
    --         start = "🚀",
    --         task = "📌",
    --     },
    -- },
})

require("vim._core.ui2").enable({})

vim.cmd([[packadd nvim.undotree]])
vim.keymap.set("n", "<leader>u", function()
    require("undotree").open({ command = "leftabove 40vnew" })
end)
