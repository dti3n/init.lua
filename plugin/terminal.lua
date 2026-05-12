vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("dtien.terminal_open", {}),
    callback = function(args)
        local bufnr = args.buf
        vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = bufnr,
            callback = function()
                vim.opt_local.cursorline = false
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })

        if vim.fn.mode() == "n" then
            vim.opt_local.cursorline = true
        else
            vim.opt_local.cursorline = false
        end

        vim.cmd("startinsert")
    end,
})

vim.api.nvim_create_user_command("Nterm", "tabe | term", {})
vim.api.nvim_create_user_command("Vterm", "vsp | vertical resize -12 | term", {})
vim.api.nvim_create_user_command("Hterm", "sp | resize -8 | term", {})
