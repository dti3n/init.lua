local o = vim.opt
local g = vim.g

-- need to put this at top
g.mapleader = " "

-- why? see :h sql-completion
g.omni_sql_no_default_maps = 1

o.statusline =
    [[%< %{v:lua.vim.api.nvim_get_mode().mode} | %f %h%w%m%r%=%-14.(%l,%c%V%) %L | %P ]]

o.inccommand = "split"
o.showmode = false

o.nu = true
o.rnu = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true

o.splitright = true
o.splitbelow = true

o.wrap = false
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.swapfile = false
o.backup = false
o.undofile = true

o.termguicolors = true

o.completeopt = "menuone,preview,noselect"
o.shortmess = vim.o.shortmess .. "c"

o.signcolumn = "yes"

o.scrolloff = 8

o.colorcolumn = "80"
o.textwidth = 80 -- see :help gq

o.updatetime = 100

o.fixeol = false

vim.cmd("colorscheme retrobox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
