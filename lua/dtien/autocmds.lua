local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local my_group = augroup("MyGroup", {})
local yank_group = augroup("HighlightYank", {})
local term_open_group = augroup("CustomTermOpen", {})

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

autocmd("LspAttach", {
    group = my_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "" })
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

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

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
    end,
})

autocmd("TermOpen", {
    group = term_open_group,
    callback = function()
        local o = vim.opt
        o.cursorline = true
        o.number = false
        o.relativenumber = false
    end,
})

autocmd("BufEnter", {
    pattern = { "*.blade.php" },
    command = "set filetype=php",
})
