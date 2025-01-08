return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = { preset = "enter" },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        completion = {
            menu = { border = "single" },
            documentation = { window = { border = "single" } },
            accept = { auto_brackets = { enabled = false } },
            list = { selection = { preselect = false, auto_insert = false } },
        },
        signature = { window = { border = "single" } },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            cmdline = {},
        },
        snippets = { preset = "luasnip" },
    },
}
