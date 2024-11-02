function on_background_change(settings)
    settings = settings or {}
    local bg_mode = vim.o.background
    local theme = settings.theme
    local config = settings[bg_mode] or { color = "default" }
    local setup = config.setup
    if theme then
        local ok, err = pcall(function()
            require(theme)
        end)
        if not ok then
            print("Failed to load colorscheme")
            return
        end

        require(theme).setup(setup or {})
    end

    vim.cmd("colorscheme " .. config.color)
end
