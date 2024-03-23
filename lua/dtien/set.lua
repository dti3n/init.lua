local o = vim.opt
local g = vim.g

-- need to put this at top
g.mapleader = " "

-- o.statusline = "[%{v:lua.vim.api.nvim_get_mode().mode}] %f %m %= %y %5l:%-4c [%L/%P]"
-- o.statusline = "%y %f %m %= [%5l:%-4c] [%L]"
-- o.showtabline = 3
-- o.cursorline = true
-- o.cmdheight = 0
-- o.laststatus = 3
-- o.winbar = "%= %m %f %="

o.inccommand = "split"

o.guicursor = ""
o.showmode = true
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
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.termguicolors = true

o.completeopt = 'menuone,preview,noselect'
o.shortmess = vim.o.shortmess .. 'c'

o.scrolloff = 8
o.signcolumn = "yes"
o.colorcolumn = "120"
o.updatetime = 100

o.fixeol = false

-- o.fillchars = {
--     stl = "─",
--     stlnc = "─",
-- }

-- o.fillchars:append({
--     horiz = '━',
--     horizup = '┻',
--     horizdown = '┳',
--     vert = '┃',
--     vertleft = '┨',
--     vertright = '┣',
--     verthoriz = '╋',
-- })

-- o.list = true
-- o.listchars = 'eol:↵'
-- o.listchars = 'eol:↵,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
