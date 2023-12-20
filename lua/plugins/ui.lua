return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'auto',
                    globalstatus = false,
                    icons_enabled = false,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { function() return vim.api.nvim_get_mode().mode end },
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
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            plugins = {
                gitsigns = true,
                tmux = true,
            },
        },
        keys = { { "\\z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    },
}
