vim.pack.add({
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
})

vim.g.db_ui_use_nerd_fonts = 1

-- save location (including connection strings + saved queries)
-- (default): ~/.local/share/db_ui
-- (example): vim.g.db_ui_save_location = "~/personal/db_ui_queries"

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "sql", "mysql" },
--     callback = function()
--         vim.opt_local.commentstring = "-- %s"
--     end,
-- })
