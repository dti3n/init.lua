return {
    "mfussenegger/nvim-lint",
    cmd = { "Spell" },
    config = function()
        local lint = require("lint")
        local linting_enabled = false -- disable by default
        local lint_augroup =
            vim.api.nvim_create_augroup("Linting", { clear = true })
        local toggle_lint = function()
            if linting_enabled then
                vim.api.nvim_del_augroup_by_id(lint_augroup)
                vim.diagnostic.reset()
                print("Linting disabled")
            else
                lint_augroup =
                    vim.api.nvim_create_augroup("Linting", { clear = true })
                vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                    group = lint_augroup,
                    callback = function()
                        -- requires: cspell
                        -- runs: npm install -g cspell
                        require("lint").try_lint("cspell")
                    end,
                })
                require("lint").try_lint()
                print("Linting enabled")
            end
            linting_enabled = not linting_enabled
        end

        vim.api.nvim_create_user_command("Spell", toggle_lint, {
            desc = "Toggle linting on/off",
        })
    end,
}
