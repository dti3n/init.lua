local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local my_group = augroup("MyGroup", {})
local yank_group = augroup("HighlightYank", {})

usercmd("Nterm", "tabe | term", {})
usercmd("Vterm", "vsp | vertical resize -12 | term", {})
usercmd("Hterm", "sp | resize -8 | term", {})
usercmd("Bd", "up | %bd | e#", {}) -- delete all hidden buffers

usercmd("YankPathToClipboard", function()
    local file_path = vim.fn.expand("%:p")
    vim.fn.setreg("+", file_path)
    print("Yanked file path to clipboard: " .. file_path)
end, { desc = "Yank the full path of the current file to the clipboard" })

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

-- autocmd("BufEnter", {
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
--     end,
-- })

autocmd("LspAttach", {
    group = my_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- client.server_capabilities.semanticTokensProvider = nil

        if client ~= nil and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
                true,
                client.id,
                event.buf,
                { autotrigger = true }
            )
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

        local diagnostic_opts = { float = { border = "single" } }
        vim.diagnostic.config(diagnostic_opts)

        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "" })
        end

        -- :help lsp-defaults

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

        nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")
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
    end,
})
