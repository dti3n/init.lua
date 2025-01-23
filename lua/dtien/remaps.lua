-- :help default-mappings (remember to check default keymaps for new version)

-- Move line up and down VISUAL modes
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Adjusting split sizes
vim.keymap.set("n", "<C-Left>", ":vertical resize +3<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -3<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +3<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -3<CR>")

-- Keep cursor position when <J>
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle
-- vim.keymap.set("n", "n", "nzzzv", { noremap = true })
-- vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Paste without overwrite paste-register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deleting to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Swiching tabs
vim.keymap.set("n", "\\1", "1gt")
vim.keymap.set("n", "\\2", "2gt")
vim.keymap.set("n", "\\3", "3gt")
vim.keymap.set("n", "\\4", "4gt")
vim.keymap.set("n", "\\5", "5gt")

-- So gooooood
vim.keymap.set("n", "<C-t>", "<C-6>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("t", [[<C-\>]], [[<C-\><C-n>]])
vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "\\x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Remove trailing whitespace and keep cursor position
vim.keymap.set({ "n", "v" }, "\\tr", function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("[vV]") then
        vim.cmd([[keeppatterns '<,'>s/\s\+$//e]])
    else
        vim.cmd([[keeppatterns %s/\s\+$//e]])
    end
    vim.api.nvim_win_set_cursor(0, curpos)
end, { silent = true })

vim.keymap.set("n", "<up>", "gk")
vim.keymap.set("n", "<down>", "gj")

vim.keymap.set("n", "j", function(...)
    local count = vim.v.count

    if count == 0 then
        return "gj"
    else
        return "j"
    end
end, { expr = true })

vim.keymap.set("n", "k", function(...)
    local count = vim.v.count

    if count == 0 then
        return "gk"
    else
        return "k"
    end
end, { expr = true })
