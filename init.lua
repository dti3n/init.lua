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
