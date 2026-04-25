vim.g.mapleader = " "

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

require("dtien.git")
require("dtien.lsp")
require("dtien.snippets")
require("dtien.treesitter")

require("vim._core.ui2").enable({})

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
