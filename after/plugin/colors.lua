local status, color = pcall(require, "rose-pine")
if (not status) then return end

color.setup({
    disable_italics = true,
    disable_background = true,
    disable_float_background = true,
    -- highlight_groups = {
    --     StatusLine = { fg = "love", bg = "love", blend = 10 },
    --     StatusLineNC = { fg = "subtle", bg = "surface" },
    -- },
})

function set_scheme(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
end

set_scheme()
