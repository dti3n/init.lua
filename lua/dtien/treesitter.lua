vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("dtien.treesitter.config", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
            return
        end
        pcall(vim.treesitter.start)
    end,
})

vim.treesitter.language.register("javascript", { "javascriptreact", "jsx" })
vim.treesitter.language.register("typescript", { "typescriptreact", "tsx" })
