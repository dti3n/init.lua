local o = vim.opt
local g = vim.g

g.mapleader = " "

-- o.winbar = "%=%m %f"
o.laststatus = 3
o.showtabline = 2
o.cursorline = true

o.nu = true
o.relativenumber = true

-- Tab = 4 spaces character
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

o.swapfile = false
o.backup = false

o.termguicolors = true

o.scrolloff = 8
o.signcolumn = "yes"
-- o.colorcolumn = "120"

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
o.updatetime = 50

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
-- o.listchars = 'eol:¬,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

