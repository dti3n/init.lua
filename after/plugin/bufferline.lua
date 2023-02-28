local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
    options = {
        mode = "buffers", -- mode = "tabs" for only show tabpages
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_buffer_default_icon = false,
        show_close_icon = false,
        -- diagnostics = "nvim_lsp",
        -- diagnostics_indicator = function(count, level)
        --     local icon = level:match("error") and "E:" or "W:"
        --     return " " .. icon .. count
        -- end
    },
    highlights = {
        buffer_selected = {
            bold = false,
            italic = false,
        },
        tab_selected = {
            fg = '#ffffff',
        },
    },
})

vim.keymap.set("n", "<C-p>", ":BufferLinePick<CR>", { silent = true })
vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>", { silent = true })

vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { silent = true })
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { silent = true })
vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { silent = true })
vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { silent = true })
vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { silent = true })
vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { silent = true })
vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { silent = true })
vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { silent = true })
vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { silent = true })
vim.keymap.set("n", "<leader>0", ":BufferLineGoToBuffer -1<CR>", { silent = true })
