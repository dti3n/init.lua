local o = vim.opt
local g = vim.g

-- need to put this at top
g.mapleader = " "

-- why? see :h sql-completion
g.omni_sql_no_default_maps = 1

o.statusline = [[%< %f %h%w%m%r%=%-14.(%l,%c%V%) %L | %P ]]

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

o.fixeol = false

o.path:append("**") -- see :help starstar

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

if vim.fn.executable("rg") == 1 then
    o.grepprg =
        'rg --vimgrep --smart-case --hidden --color=never --glob="!.git" --glob="!**/node_modules/**" --glob="!**/dist/**" --glob="!**/vendor/**" --glob="!*.log"'
else
    o.grepprg =
        'grep -HRIn $* . --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=vendor --exclude="*.log"'
end

-- colors

local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end
vim.cmd("colorscheme retrobox")
hi("Normal", { bg = "none", fg = "#ebdbb2" })
hi("NormalFloat", { bg = "none" })
hi("Statusline", { bg = "#504945", bold = false })
hi("SignColumn", { bg = "none" })
hi("ColorColumn", { bg = "#504945" })
hi("WinSeparator", { bg = "none" })
-- hi("DiffAdd", { bold = false, fg = "none", bg = "#2e4b2e" })
-- hi("DiffDelete", { bold = false, fg = "none", bg = "#4c1e15" })
-- hi("DiffChange", { bold = false, fg = "none", bg = "#45565c" })
-- hi("DiffText", { bold = false, fg = "none", bg = "#996d74" })
