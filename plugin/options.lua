local o = vim.opt
local g = vim.g

-- :h sql-completion
g.omni_sql_no_default_maps = 1

o.statusline = [[%<%f %h%w%m%r %=%8.(%l,%c%V%) | %P]]

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

-- o.autocomplete = false
-- o.complete = ".^5,w^5,b^5"
o.completeopt = "fuzzy,menuone,noselect,popup"
o.shortmess:append("c")

o.signcolumn = "yes"
o.scrolloff = 8

o.colorcolumn = "80"
o.textwidth = 80 -- see :help gq

o.path:append("**") -- see :help starstar

-- o.fixeol = false

-- o.pumborder = "single"
-- o.winborder = "single"

-- o.title = true
-- o.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

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
