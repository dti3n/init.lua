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
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { { 'filename', path =  1 } },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_c = { { 'filename', path =  1 } },
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
                window = { margin = { vertical = 0, horizontal = 0 } },
                hide = { cursorline = true },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':.') -- relative path (use :t for only the filename)
                    local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "[+]" or ""
                    local buffer = { { modified }, { " " }, { filename } }
                    return buffer
                end
            })
        end
    },
}
