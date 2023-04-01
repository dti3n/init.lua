local present, feline = pcall(require, "feline")
if not present then
    return
end

local theme = {
    aqua = "#7AB0DF",
    bg = "#1C212A",
    blue = "#5FB0FC",
    cyan = "#70C0BA",
    darkred = "#FB7373",
    fg = "#C7C7CA",
    gray = "#222730",
    green = "#79DCAA",
    lime = "#54CED6",
    orange = "#FFD064",
    pink = "#D997C8",
    purple = "#C397D8",
    red = "#F87070",
    yellow = "#FFE59E"
}

local mode_theme = {
    ["NORMAL"] = theme.green,
    ["OP"] = theme.cyan,
    ["INSERT"] = theme.aqua,
    ["VISUAL"] = theme.yellow,
    ["LINES"] = theme.darkred,
    ["BLOCK"] = theme.orange,
    ["REPLACE"] = theme.purple,
    ["V-REPLACE"] = theme.pink,
    ["ENTER"] = theme.pink,
    ["MORE"] = theme.pink,
    ["SELECT"] = theme.darkred,
    ["SHELL"] = theme.cyan,
    ["TERM"] = theme.lime,
    ["NONE"] = theme.gray,
    ["COMMAND"] = theme.blue,
}

local component = {}

component.vim_mode = {
    provider = function()
        return vim.api.nvim_get_mode().mode:upper()
    end,
    hl = function()
        return {
            fg = "bg",
            bg = require("feline.providers.vi_mode").get_mode_color(),
            style = "bold",
            name = "NeovimModeHLColor",
        }
    end,
    left_sep = "block",
    right_sep = "block",
}

component.git_branch = {
    provider = "git_branch",
    hl = {
        fg = "fg",
        bg = "bg",
        style = "bold",
    },
    left_sep = "block",
    right_sep = "",
}

component.git_add = {
    provider = "git_diff_added",
    hl = {
        fg = "green",
        bg = "bg",
    },
    left_sep = "",
    right_sep = "",
}

component.git_delete = {
    provider = "git_diff_removed",
    hl = {
        fg = "red",
        bg = "bg",
    },
    left_sep = "",
    right_sep = "",
}

component.git_change = {
    provider = "git_diff_changed",
    hl = {
        fg = "purple",
        bg = "bg",
    },
    left_sep = "",
    right_sep = "",
}

component.separator = {
    provider = "",
    hl = {
        fg = "bg",
        bg = "bg",
    },
}

component.file_type = {
    provider = {
        name = "file_type",
        opts = {
            filetype_icon = true,
        },
    },
    hl = {
        fg = "fg",
        bg = "gray",
    },
    left_sep = "block",
    right_sep = "block",
}

component.file_name = {
    provider = {
        name = "file_info",
        opts = {
            -- type = "relative-short",
            type = "relative",
        },
    },
    hl = {
        style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
}

component.position = {
    provider = {
        name = 'position',
        opts = {
            padding = {
                line = 4,
                col = 3
            },
            format = '{line},{col}',
        },
    },
    left_sep = "block",
    right_sep = "block",
}

component.scroll_bar = {
    provider = "scroll_bar",
    hl = {
        fg = "yellow",
        style = "bold",
    },
    left_sep = "block"
}

local left = {
    component.vim_mode,
    component.git_branch,
    component.git_add,
    component.git_delete,
    component.git_change,
}

local middle = {
    component.file_name,
}

local right = {
    component.position,
    component.file_type,
    component.scroll_bar,
}

local components = {
    active = {
        left,
        middle,
        right,
    },
}

feline.setup({
    components = components,
    theme = theme,
    vi_mode_colors = mode_theme,
})
