vim.g.mapleader = " "
vim.g.omni_sql_no_default_maps = 1 -- :help sql-completion

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

require("lazy").setup("custom.plugins", {
    change_detection = {
        enabled = false,
        notify = false,
    },
})
