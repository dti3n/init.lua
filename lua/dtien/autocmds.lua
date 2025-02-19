local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local my_group = augroup("MyGroup", {})
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- autocmd({ "BufWritePre" }, {
--     group = MyGroup,
--     pattern = "*",
--     command = "%s/\\s\\+$//e",
-- })

autocmd("LspAttach", {
    group = my_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- client.server_capabilities.semanticTokensProvider = nil

        local diagnostic_opts = { float = { border = "single" } }
        -- if client.name == "solargraph" then
        --     diagnostic_opts = {
        --         float = { border = "single" },
        --         underline = {
        --             severity = { min = vim.diagnostic.severity.WARN },
        --         },
        --         virtual_text = {
        --             severity = { min = vim.diagnostic.severity.WARN },
        --         },
        --         signs = true,
        --     }
        -- end
        vim.diagnostic.config(diagnostic_opts)

        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "" })
        end

        local inmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set(
                { "i", "n" },
                keys,
                func,
                { buffer = event.buf, desc = "" }
            )
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gr", require("telescope.builtin").lsp_references)
        nmap(
            "<leader>ds",
            require("telescope.builtin").lsp_document_symbols,
            "[D]ocument [S]ymbols"
        )
        nmap(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
        )

        nmap("K", function()
            vim.lsp.buf.hover({ border = "single" })
        end, "Hover Documentation")

        inmap("<C-h>", function()
            vim.lsp.buf.signature_help({ border = "single" })
        end, "Signature Documentation")

        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap(
            "<leader>wa",
            vim.lsp.buf.add_workspace_folder,
            "[W]orkspace [A]dd Folder"
        )
        nmap(
            "<leader>wr",
            vim.lsp.buf.remove_workspace_folder,
            "[W]orkspace [R]emove Folder"
        )
        nmap("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
            if vim.lsp.buf.format then
                vim.lsp.buf.format()
            elseif vim.lsp.buf.formatting then
                vim.lsp.buf.formatting()
            end
        end, { desc = "Format current buffer with LSP" })

        -- doing both format & range format
        vim.keymap.set(
            { "n", "v" },
            "\\f",
            vim.lsp.buf.format,
            { silent = true, buffer = bufnr }
        )

        -- if client and client.server_capabilities.documentHighlightProvider then
        --     vim.api.nvim_buf_create_user_command(
        --         event.buf,
        --         "DocumentHl",
        --         function(_)
        --             vim.cmd(
        --                 [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        --             )
        --             vim.cmd(
        --                 [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        --             )
        --             vim.cmd(
        --                 [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
        --             )
        --         end,
        --         { desc = "Enable Document Highlight" }
        --     )
        -- end
    end,
})

-- -- Don't have `o` | `O` add a comment
-- autocmd("BufEnter", {
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
--     end,
-- })
