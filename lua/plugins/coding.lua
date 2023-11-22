return {
    { "windwp/nvim-autopairs", enabled = false, opts = {} },

    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                post_hook = nil,
            })
        end
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        version = "*",
        config = function()
            require("nvim-surround").setup ({
                 surrounds = {
                    ["e"] = {
                        add = function()
                            return { { "<% " }, { " %>" } }
                        end,
                    }
                }
            })
        end
    },
}
