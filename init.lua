vim.g.mapleader = " "

require("vim._core.ui2").enable({})
require("dtien.git")
require("dtien.snippets")
require("dtien.treesitter")
require("dtien.lsp")

vim.cmd([[packadd nvim.undotree]])
vim.keymap.set("n", "<leader>u", function()
    require("undotree").open({ command = "leftabove 40vnew" })
end)

vim.cmd("colorscheme retrobox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#504945" })
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#303030" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ebdbb2" })
