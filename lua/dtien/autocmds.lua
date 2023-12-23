local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local my_group = augroup('MyGroup', {})
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = my_group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd('LspAttach', {
    group = my_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- client.server_capabilities.semanticTokensProvider = nil

        vim.diagnostic.config({
            float = { border = "rounded" }
        })

        if client.name == "solargraph" then
            vim.diagnostic.config({
                float = { border = "rounded" },
                underline = {severity = {min = vim.diagnostic.severity.ERROR}},
                virtual_text = {severity = {min = vim.diagnostic.severity.ERROR}},
                signs = true
            })
        end

        -- :help vim.lsp.handlers.hover()
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "rounded" }
        )

        -- :help vim.lsp.handlers.signature_help()
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
        )

        local nmap = function(keys, func, desc)
            if desc then desc = 'LSP: ' .. desc end
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = '' })
        end

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

-- autocmd("TermOpen", {
--     pattern = "*",
--     command = "startinsert | set cursorline",
-- })

-- autocmd("BufEnter", {
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" }
--     end
-- })

