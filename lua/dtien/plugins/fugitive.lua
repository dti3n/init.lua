return {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gl", ":Git log -n100 <CR>", { silent = true })
        vim.keymap.set("n", "<leader>gL", ":Git log -n100 %<CR>", { silent = true })
        vim.keymap.set("n", "<leader>gb", ":Git blame %<CR>", { silent = true })
        vim.keymap.set("n", "<leader>gp", function()
            vim.ui.input({
                prompt = "git-preview > ",
            }, function(inp)
                if inp == nil then
                    return
                end

                local rev = vim.trim(inp)
                if rev == "" then
                    rev = "HEAD^"
                end

                vim.cmd({ cmd = "Gtabedit", args = { rev .. ":%" } })
            end)
        end)
    end,
}
