return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        require("luasnip.loaders.from_vscode").lazy_load({
            -- include = { "all", "javascript", "jsdoc", "ruby", "rdoc", "go", "html", "loremipsum" },
        })

        luasnip.filetype_extend("javascript", { "jsdoc" })
        luasnip.filetype_extend("ruby", { "rdoc" })
        luasnip.filetype_extend("eruby", { "html" })
        luasnip.filetype_extend("all", { "loremipsum" })

        vim.keymap.set({"i"}, "<C-k>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({"i", "s"}, "<C-j>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { silent = true })
    end
}

