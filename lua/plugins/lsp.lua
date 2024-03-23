return {
    'neovim/nvim-lspconfig',
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local opts = { noremap = true, silent = true }

        -- vim.diagnostic.config({
        --     underline = {severity = {min = vim.diagnostic.severity.WARN}},
        --     virtual_text = {severity = {min = vim.diagnostic.severity.WARN}},
        --     signs = {severity = {min = vim.diagnostic.severity.WARN}},
        -- })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local nmap = function(keys, func, desc)
                    if desc then desc = 'LSP: ' .. desc end
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = '' })
                end

                -- client.server_capabilities.semanticTokensProvider = nil

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

                vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
                    if vim.lsp.buf.format then
                        vim.lsp.buf.format()
                    elseif vim.lsp.buf.formatting then
                        vim.lsp.buf.formatting()
                    end
                end, { desc = 'Format current buffer with LSP' })

                -- doing both format & range format
                vim.keymap.set({ 'n', 'v' }, '\\f', vim.lsp.buf.format, { silent = true, buffer = bufnr })
            end
        })

        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup_handlers {
            function(server_name) -- default handler (optional)
                if server_name == "tsserver" then
                    server_name = "ts_ls"
                end
                require("lspconfig")[server_name].setup{
                    capabilities = capabilities,
                }
            end,
        }
    end
}

