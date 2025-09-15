-- require("nvim-treesitter").install({
--     "vimdoc",
--     "jsdoc",
--     "lua",
--     "javascript",
--     "typescript",
--     "tsx",
--     "go",
--     "ruby",
--     "php",
--     "bash",
--     "html",
--     "embedded_template",
-- })

-- Requirements:
-- * v0.11.0 or later (nightly)
-- * tar, curl, gcc
-- * tree-sitter CLI (0.25.0 or later) (can install with mason)
-- * node v23.0.0 or later

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom-treesitter-config", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
            return
        end
        pcall(vim.treesitter.start)
    end,
})
