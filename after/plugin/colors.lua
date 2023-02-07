local status, color = pcall(require, "rose-pine")
if (not status) then return end

color.setup({
    disable_background = true,
    disable_italics = true,
})

function set_scheme(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
end

set_scheme()
