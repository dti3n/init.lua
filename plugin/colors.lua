local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end
vim.cmd("colorscheme retrobox")
hi("Normal", { bg = "none", fg = "#ebdbb2" }) -- need to set fg or it will base on the terminal's color
hi("NormalFloat", { bg = "none" })
hi("Identifier", { fg = "#ebdbb2" })
-- hi("Statusline", { bg = "#504945", bold = false })
-- hi("ColorColumn", { bg = "#504945" })
hi("SignColumn", { bg = "none" })
hi("WinSeparator", { bg = "none" })
