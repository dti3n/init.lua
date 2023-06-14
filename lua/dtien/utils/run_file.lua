local lang_maps = {
    cpp = { build = "g++ % -o %:r", exec = "./%:r" },
    java = { build = "javac %", exec = "java ./%:r" },
    go = { build = "go build", exec = "go run %" },
    typescript = { exec = "tsc" },
    javascript = { exec = "node %" },
    python = { exec = "python3 %" }, -- or { exec = "python %"}
    rust = { exec = "cargo run" },
}

for lang, data in pairs(lang_maps) do
    if data.build ~= nil then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = lang,
            command = "nnoremap \\b :!" .. data.build .. "<CR>"
        })
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = lang,
        command = "nnoremap \\e :split<CR>:terminal " .. data.exec .. "<CR>"
    })

    -- if data.build ~= nil then
    --     vim.api.nvim_create_autocmd("FileType", {
    --         pattern = lang,
    --         callback = function()
    --             vim.api.nvim_create_user_command("Build", "!" .. data.build, {})
    --         end
    --     })
    -- end
    --
    -- vim.api.nvim_create_autocmd("FileType", {
    --     pattern = lang,
    --     callback = function()
    --         vim.api.nvim_create_user_command("Run", "split | terminal " .. data.exec, {})
    --     end
    -- })
end

