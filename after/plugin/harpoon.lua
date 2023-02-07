local status, harpoon = pcall(require, "harpoon")
if (not status) then return end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>a", function()
    mark.add_file()
    print('[Harpoon] mark: ' .. vim.fn.expand('%:t'))
end, { desc = 'Harpoon: Add file' })

vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = 'Harpoon: Toggle quick-menu' })

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = 'Harpoon: Go to marked-file 1' })
vim.keymap.set("n", "<C-y>", function() ui.nav_file(2) end, { desc = 'Harpoon: Go to marked-file 2' })
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end, { desc = 'Harpoon: Go to marked-file 3' })
vim.keymap.set("n", "<C-i>", function() ui.nav_file(3) end, { desc = 'Harpoon: Go to marked-file 4' })
