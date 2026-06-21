local o = vim.opt
local g = vim.g

g.netrw_banner = 0
g.netrw_altfile = 1
g.netrw_winsize = 30
g.netrw_hide = 0

g.omni_sql_no_default_maps = 1 -- :h sql-completion

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

o.completeopt = "fuzzy,menuone,noselect,popup"
o.shortmess:append("c")

o.signcolumn = "yes"
o.colorcolumn = "80"
o.textwidth = 80 -- :h gq

o.path:append("**") -- :h starstar

o.fixeol = false

o.winborder = "single"

o.wildignore = {
    "*.o",
    "*.obj",
    "*.pyc",
    "*.class",
    "*.swp",
    "*.swo",
    "*.swn",
    "*.bak",
    "*.tmp",
    "*.temp",
    "*.log",
    "*.cache",
    "**/node_modules/**",
    "**/dist/**",
    "**/build/**",
    "**/vendor/**",
    "*.git/**",
    "*.hg/**",
    "*.svn/**",
    "*.jpg",
    "*.png",
    "*.gif",
    "*.pdf",
    "*.zip",
    "*.tar.gz",
    "__pycache__/**",
    "*.egg-info/**",
    "*.DS_Store",
}
