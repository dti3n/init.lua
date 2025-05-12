return {
    "echasnovski/mini.statusline",
    enabled = false,
    config = function()
        local statusline = require("mini.statusline")
        statusline.setup({ use_icons = false })
        statusline.section_location = function()
            return "%2l:%-2v %L"
        end
        statusline.section_diagnostics = function()
            return ""
        end
        statusline.section_lsp = function()
            return ""
        end
        statusline.section_git = function()
            return ""
        end
    end,
}
