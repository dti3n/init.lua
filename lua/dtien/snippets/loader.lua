local M = {}

M.global = "global"

M.by_filetype = {
    javascript = { "javascript.jsdoc" },
    typescript = { "javascript.jsdoc" },
    javascriptreact = { "javascript.jsdoc", "javascript.react" },
    typescriptreact = { "javascript.jsdoc", "javascript.react" },
    ruby = { "ruby.ruby", "ruby.rdoc" },
    eruby = { "ruby.erb" },
    lua = { "lua" },
    go = { "go" },
}

return M
