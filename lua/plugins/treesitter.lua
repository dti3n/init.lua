return {
    'nvim-treesitter/nvim-treesitter',
    -- event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    dependencies = {
        { 'windwp/nvim-ts-autotag', config = true },
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "lua", "javascript", "typescript", "tsx", "ruby" },
            auto_install = false,
            sync_install = false,

            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },

            indent = { enable = true, disable = { 'ruby' } },
        })
    end
}

