local o = vim.opt
local g = vim.g

-- :h sql-completion
g.omni_sql_no_default_maps = 1

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

o.completeopt = "menuone,preview,noselect"

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

-- colors
local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end
vim.cmd("colorscheme retrobox")
hi("Normal", { bg = "none", fg = "#ebdbb2" }) -- need to set fg or it will base on the terminal's color
hi("NormalFloat", { bg = "none" })
hi("Identifier", { fg = "#ebdbb2" })
hi("Statusline", { bg = "#504945", bold = false })
hi("ColorColumn", { bg = "#504945" })
hi("SignColumn", { bg = "none" })
hi("WinSeparator", { bg = "none" })
