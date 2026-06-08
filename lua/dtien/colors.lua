local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local function set_theme(mode)
    vim.cmd("colorscheme retrobox")
    vim.cmd("set background=" .. mode)
    if mode == "light" then
        hi("Identifier", { fg = "#3c3836" })
    else
        hi("Normal", { bg = "none", fg = "#ebdbb2" })
        hi("NormalFloat", { bg = "none", fg = "#ebdbb2" })
        hi("Identifier", { fg = "#ebdbb2" })
        hi("SignColumn", { bg = "none" })
        hi("ColorColumn", { bg = "#504945" })
        hi("WinSeparator", { bg = "none", fg = "#303030" })
        hi("FloatBorder", { fg = "#ebdbb2" })
        hi("Pmenu", { bg = "none", fg = "#ebdbb2" })
        hi("PmenuBorder", { bg = "none", fg = "#ebdbb2" })
    end
end

set_theme("dark")

vim.api.nvim_create_user_command("ToggleBG", function()
    local next = vim.o.background == "dark" and "light" or "dark"
    set_theme(next)
end, {})
