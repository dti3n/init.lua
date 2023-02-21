local status, nvim_tree = pcall(require, "nvim-tree")
if (not status) then return end

nvim_tree.setup({
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "v", action = "vsplit" },
                { key = "O", action = "cd" }
            },
        },
    },
    -- update_cwd = true,
    -- update_focused_file = {
    --     enable = true,
    --     update_cwd = true,
    -- },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
})
