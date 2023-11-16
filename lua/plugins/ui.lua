return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'auto',
                    globalstatus = true,
                    icons_enabled = false,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff'},
                    lualine_c = { { 'filename', path =  1 } },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            }
        end
    },

    {
        "b0o/incline.nvim",
        enabled = true,
        event = "BufReadPre",
        priority = 1200,
        config = function()
            require('incline').setup({
                window = { margin = { vertical = 0, horizontal = 1 } },
                hide = { cursorline = true },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                    local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "[+] " or ""
                    local buffer = {
                        { modified },
                        { ft_icon, guifg = ft_color },
                        { " " },
                        { filename },
                    }
                    return buffer
                end
            })
        end
    },

}
