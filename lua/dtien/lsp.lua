vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

-- see :h vim.lsp.config
vim.lsp.config("ts_ls", {
    root_markers = {
        ".git",
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
    },
    -- single_file_support = false
})

vim.lsp.config("tailwindcss", {
    filetypes = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
    },
})

vim.lsp.config("harper_ls", {
    -- filetypes = {
    --     "gitcommit",
    --     "markdown",
    -- },
    settings = {
        ["harper-ls"] = {
            linters = {
                SentenceCapitalization = false,
                UseTitleCase = false,
                SpellCheck = true,
            },
        },
    },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})

require("mason").setup({})
require("mason-lspconfig").setup({
    automatic_enable = {
        exclude = { "harper_ls" },
    },
})

vim.api.nvim_create_user_command("HarperOn", function()
    vim.lsp.enable("harper_ls")
end, { desc = "LSP enable harper_ls" })

vim.api.nvim_create_user_command("HarperOff", function()
    vim.lsp.enable("harper_ls", false)
end, { desc = "LSP disable harper_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("dtien.lsp.config", {}),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- client.server_capabilities.semanticTokensProvider = nil

        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "" })
        end

        vim.lsp.document_color.enable(false) -- i dont like this
        vim.diagnostic.config({ float = { border = "single" } })

        if client and client:supports_method("textDocument/completion") then
            -- vim.opt_local.complete = "o"

            -- -- :help lsp-autocompletion
            -- -- triggerCharacters mostly are { '"', "'", "`", " ", ".", "(", "[", "]", "!", "/", "-", ":" }
            -- -- enhance this to trigger on every characters
            -- -- need to place this before the vim.lsp.completion.enable
            -- local completion_provider = client.server_capabilities.completionProvider
            -- if completion_provider then
            --     completion_provider.triggerCharacters = completion_provider.triggerCharacters or {}
            --     local tchars = completion_provider.triggerCharacters ---@type string[]
            --     local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            --     for _, c in ipairs(vim.split(chars, "")) do
            --         if not vim.tbl_contains(tchars, c) then
            --             table.insert(tchars, c)
            --         end
            --     end
            -- end

            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })

            vim.keymap.set("i", "<C-Space>", function()
                vim.lsp.completion.get()
            end)

            vim.keymap.set("i", "<CR>", function()
                if vim.fn.pumvisible() == 1 then
                    return "<C-y>"
                end
                return "<CR>"
            end, { expr = true, silent = true })
        end

        -- :help lsp-defaults

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

        nmap("K", function()
            vim.lsp.buf.hover({ border = "single" })
        end, "LSP Hover")

        nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        vim.keymap.set("i", "<C-s>", function()
            vim.lsp.buf.signature_help({ border = "single" })
        end, { buffer = event.buf, desc = "LSP Signature Help" })

        vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
            if vim.lsp.buf.format then
                vim.lsp.buf.format()
            elseif vim.lsp.buf.formatting then
                vim.lsp.buf.formatting()
            end
        end, { desc = "Format current buffer with LSP" })
    end,
})
