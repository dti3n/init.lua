return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        local on_attach = function(client, bufnr)
            local nmap = function(keys, func, desc)
                if desc then desc = 'LSP: ' .. desc end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            client.server_capabilities.semanticTokensProvider = nil

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('gr', require('telescope.builtin').lsp_references)
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                if vim.lsp.buf.format then
                    vim.lsp.buf.format()
                elseif vim.lsp.buf.formatting then
                    vim.lsp.buf.formatting()
                end
            end, { desc = 'Format current buffer with LSP' })
        end

        -- local servers = {
        --     rust_analyzer = {},
        --     tsserver = {},
        --     tailwindcss = {},
        --     lua_ls = {
        --         Lua = {
        --             workspace = { checkThirdParty = false },
        --             telemetry = { enable = false },
        --         },
        --     },
        -- }

        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local mason_lspconfig = require 'mason-lspconfig'

        -- mason_lspconfig.setup {
        --     ensure_installed = vim.tbl_keys(servers),
        -- }

        mason_lspconfig.setup_handlers {
            function(server_name) -- default handler (optional)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    -- settings = servers[server_name],
                }
            end,

            -- Handler override for specific server
            ['tailwindcss'] = function()
                require'lspconfig'.tailwindcss.setup {
                    root_dir = require('lspconfig').util.root_pattern(
                        'tailwind.config.js',
                        'tailwind.config.ts',
                        'postcss.config.js',
                        'postcss.config.ts'
                    ),
                }
            end,

            -- ["rust_analyzer"] = function ()
            --     require("rust-tools").setup {}
            -- end

        }

    end
}

