local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local function set_theme(mode)
    vim.cmd("colorscheme retrobox")
    vim.cmd("set background=" .. mode)
    if mode == "light" then
        -- hi("Identifier", { fg = "#3c3836" })
        hi("@variable", { fg = "#3c3836" })
        hi("@lsp.type.variable", { link = "@variable" })
    else
        hi("Normal", { bg = "none", fg = "#ebdbb2" })
        hi("NormalFloat", { bg = "none", fg = "#ebdbb2" })
        hi("SignColumn", { bg = "none" })
        hi("ColorColumn", { bg = "#504945" })
        hi("WinSeparator", { bg = "none" })
        -- hi("Operator", { fg = "#fe8019" })
        -- hi("Identifier", { fg = "#ebdbb2" })
        hi("@variable", { fg = "#ebdbb2" })
        hi("@lsp.type.variable", { link = "@variable" })
    end
end

set_theme("dark")

vim.api.nvim_create_user_command("Bg", function(opts)
    set_theme(opts.args)
end, {
    nargs = 1,
    complete = function()
        return { "light", "dark" }
    end,
})
