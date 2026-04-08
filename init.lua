vim.g.mapleader = " "

local function gh(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    gh("tpope/vim-fugitive"),
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("L3MON4D3/LuaSnip"),
    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
})

require("dtien/configs/telescope")
require("dtien/configs/fugitive")
require("dtien/configs/luasnip")
require("dtien/configs/lsp")
require("dtien/configs/treesitter")

require("vim._core.ui2").enable({})

vim.cmd([[packadd nvim.undotree]])
vim.keymap.set("n", "<leader>u", function()
    require("undotree").open({ command = "leftabove 40vnew" })
end)
