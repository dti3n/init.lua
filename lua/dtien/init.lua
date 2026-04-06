require("dtien.set")
require("dtien.netrw")
require("dtien.keymaps")
require("dtien.cmd")
require("dtien.find")
require("dtien.bookmark")
require("dtien.lazy")

require("vim._core.ui2").enable({})

vim.cmd([[packadd nvim.undotree]])
vim.keymap.set("n", "<leader>u", function()
    require("undotree").open({ command = "leftabove 40vnew" })
end)
