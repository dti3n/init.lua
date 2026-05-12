local set = vim.opt_local

set.nu = true
set.rnu = true
set.cc = ""

vim.keymap.set("n", "a", "%", { remap = true, buffer = true, silent = true })
vim.keymap.set("n", "?", "<CMD>help netrw-quickmap<CR>", { remap = true, buffer = true, silent = true })
