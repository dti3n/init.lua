return {
    'nvim-treesitter/nvim-treesitter',
    -- event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
        { 'windwp/nvim-ts-autotag', config = true },
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "vimdoc", "lua", "javascript", "typescript", "tsx", "rust", "python", "ruby" },
            auto_install = false,
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-h>',
                    node_decremental = '<c-s>',
                },
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                        -- ['<leader>c'] = '@class.outer',
                        -- ['<leader>m'] = '@function.outer',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                        -- ['<leader>C'] = '@class.outer',
                        -- ['<leader>M'] = '@function.outer',
                    },
                },
            },
        }
    end
}

