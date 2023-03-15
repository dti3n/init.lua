local status, harpoon = pcall(require, "harpoon")
if (not status) then return end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>m", function()
    mark.add_file()
    print('[Harpoon] mark: ' .. vim.fn.expand('%:t'))
end, { desc = 'Harpoon: Add file' })

vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = 'Harpoon: Toggle quick-menu' })

vim.keymap.set("n", [[\1]], function() ui.nav_file(1) end, { desc = 'Harpoon: Go to marked-file 1' })
vim.keymap.set("n", [[\2]], function() ui.nav_file(2) end, { desc = 'Harpoon: Go to marked-file 2' })
vim.keymap.set("n", [[\3]], function() ui.nav_file(3) end, { desc = 'Harpoon: Go to marked-file 3' })
vim.keymap.set("n", [[\4]], function() ui.nav_file(4) end, { desc = 'Harpoon: Go to marked-file 4' })
vim.keymap.set("n", [[\5]], function() ui.nav_file(5) end, { desc = 'Harpoon: Go to marked-file 5' })

-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = 'Harpoon: Go to marked-file 1' })
-- vim.keymap.set("n", "<C-g>", function() ui.nav_file(2) end, { desc = 'Harpoon: Go to marked-file 2' })
-- vim.keymap.set("n", "<C-y>", function() ui.nav_file(3) end, { desc = 'Harpoon: Go to marked-file 3' })
-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(4) end, { desc = 'Harpoon: Go to marked-file 4' })

