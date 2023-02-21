local fn = vim.fn
local M = {}
local active_tab = 'TabLineSel'
local inactive_tab = 'TabLine'
local default_name = '[No Name]'

M.render = function()
    local line = ''
    for tab = 1, fn.tabpagenr('$') do
        local winnr = fn.tabpagewinnr(tab)
        local buflist = fn.tabpagebuflist(tab)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)

        if bufname == '' then
            bufname = default_name
        else
            bufname = '[' .. fn.fnamemodify(bufname, ':t'):gsub('%%', '%%%%') .. ']'
        end

        local modified = fn.getbufvar(bufnr, '&mod')

        line = line
        .. table.concat({
            ' ',
            '%#',
            tab == fn.tabpagenr() and active_tab or inactive_tab,
            '#',
            tab,
            ':',
            bufname,
            modified == 1 and ' [+]' or '',
            ' '
        })
    end

    return line
end

Tabline = setmetatable(M, {
    __call = function(self)
        return self['render']()
    end,
})

vim.o.tabline = '%!v:lua.Tabline()'

