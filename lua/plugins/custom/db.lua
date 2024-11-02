return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod",
        lazy = true,
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1

        -- save location (including connection strings + saved queries)
        -- (default): ~/.local/share/db_ui
        -- (example): vim.g.db_ui_save_location = "~/personal/db_ui_queries"
        vim.g.db_ui_save_location = "~/personal/db_ui_queries"
    end,
}
