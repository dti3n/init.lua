vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "one"
vim.o.termguicolors = true

-- Palette

local c = {
    none = "none",
    black = "#101012",
    bg0 = "#232326",
    bg1 = "#2c2d31",
    bg2 = "#35363b",
    bg3 = "#37383d",
    bg_d = "#1b1c1e",
    bg_blue = "#68aee8",
    bg_yellow = "#e2c792",
    fg = "#a7aab0",
    purple = "#bb70d2",
    green = "#8fb573",
    orange = "#c49060",
    blue = "#57a5e5",
    yellow = "#dbb671",
    cyan = "#51a8b3",
    red = "#de5d68",
    grey = "#5a5b5e",
    light_grey = "#818387",
    dark_cyan = "#2b5d63",
    dark_red = "#833b3b",
    dark_yellow = "#7c5c20",
    dark_purple = "#79428a",
    diff_add = "#282b26",
    diff_delete = "#2a2626",
    diff_change = "#1a2a37",
    diff_text = "#2c485f",
}

-- Style defaults

local style = {
    transparent = true, -- true -> Normal bg becomes none
    ending_tildes = true, -- true -> ~ at end of buffer uses grey instead of bg
    term_colors = true, -- set terminal palette colours

    -- per-token formatting: "none" | "bold" | "italic" | "bold,italic" | ...
    strings = "none",
    comments = "none",
    keywords = "none",
    functions = "none",
    variables = "none",
    constants = "none",
}

-- Helpers

--- Blend hex colour `hex` toward `bg` by `alpha` (0 = bg, 1 = hex).
local function darken(hex, alpha, bg)
    local function to_rgb(h)
        return tonumber(h:sub(2, 3), 16), tonumber(h:sub(4, 5), 16), tonumber(h:sub(6, 7), 16)
    end
    local r1, g1, b1 = to_rgb(hex)
    local r2, g2, b2 = to_rgb(bg)
    local r = math.floor(r1 * alpha + r2 * (1 - alpha))
    local g = math.floor(g1 * alpha + g2 * (1 - alpha))
    local b = math.floor(b1 * alpha + b2 * (1 - alpha))
    return string.format("#%02x%02x%02x", r, g, b)
end

--- Apply a highlight group from a spec table.
--- spec keys: fg, bg, fmt (vim format string), sp (special/undercurl colour)
local function hi(group, spec)
    local opts = { fg = spec.fg, bg = spec.bg, sp = spec.sp }
    if spec.fmt and spec.fmt ~= "none" then
        for _, attr in ipairs(vim.split(spec.fmt, ",")) do
            opts[vim.trim(attr)] = true
        end
    end
    vim.api.nvim_set_hl(0, group, opts)
end

-- Named color shortcuts

local color = {
    Fg = { fg = c.fg },
    LightGrey = { fg = c.light_grey },
    Grey = { fg = c.grey },
    Red = { fg = c.red },
    Cyan = { fg = c.cyan },
    Yellow = { fg = c.yellow },
    Orange = { fg = c.orange },
    Green = { fg = c.green },
    Blue = { fg = c.blue },
    Purple = { fg = c.purple },
}

local bg0 = style.transparent and c.none or c.bg0

-- Common / UI highlights

local common = {
    Normal = { fg = c.fg, bg = bg0 },
    Terminal = { fg = c.fg, bg = bg0 },
    EndOfBuffer = { fg = style.ending_tildes and c.grey or c.bg0, bg = bg0 },
    FoldColumn = { fg = c.fg, bg = style.transparent and c.none or c.bg1 },
    Folded = { fg = c.fg, bg = style.transparent and c.none or c.bg1 },
    SignColumn = { fg = c.fg, bg = bg0 },
    ToolbarLine = { fg = c.fg },
    Cursor = { fmt = "reverse" },
    vCursor = { fmt = "reverse" },
    iCursor = { fmt = "reverse" },
    lCursor = { fmt = "reverse" },
    CursorIM = { fmt = "reverse" },
    CursorColumn = { bg = c.bg1 },
    CursorLine = { bg = c.bg1 },
    ColorColumn = { bg = c.bg1 },
    CursorLineNr = { fg = c.fg },
    LineNr = { fg = c.grey },
    Conceal = { fg = c.grey, bg = c.bg1 },
    Added = color.Green,
    Removed = color.Red,
    Changed = color.Blue,
    DiffAdd = { fg = c.none, bg = c.diff_add },
    DiffChange = { fg = c.none, bg = c.diff_change },
    DiffDelete = { fg = c.none, bg = c.diff_delete },
    DiffText = { fg = c.none, bg = c.diff_text },
    DiffAdded = color.Green,
    DiffChanged = color.Blue,
    DiffRemoved = color.Red,
    DiffDeleted = color.Red,
    DiffFile = color.Cyan,
    DiffIndexLine = color.Grey,

    -- Git conflict markers
    GitConflictCurrent = { bg = darken(c.green, 0.15, c.bg0) },
    GitConflictCurrentLabel = { bg = darken(c.green, 0.25, c.bg0), fmt = "bold" },
    GitConflictIncoming = { bg = darken(c.blue, 0.15, c.bg0) },
    GitConflictIncomingLabel = { bg = darken(c.blue, 0.25, c.bg0), fmt = "bold" },
    GitConflictAncestor = { bg = darken(c.purple, 0.15, c.bg0) },
    GitConflictAncestorLabel = { bg = darken(c.purple, 0.25, c.bg0), fmt = "bold" },

    Directory = { fg = c.blue },
    ErrorMsg = { fg = c.red, fmt = "bold" },
    WarningMsg = { fg = c.yellow, fmt = "bold" },
    MoreMsg = { fg = c.blue, fmt = "bold" },
    CurSearch = { fg = c.bg0, bg = c.orange },
    IncSearch = { fg = c.bg0, bg = c.orange },
    Search = { fg = c.bg0, bg = c.bg_yellow },
    Substitute = { fg = c.bg0, bg = c.green },
    MatchParen = { fg = c.none, bg = c.bg3 },
    NonText = { fg = c.grey },
    Whitespace = { fg = c.grey },
    SpecialKey = { fg = c.grey },
    Pmenu = { fg = c.fg, bg = c.bg1 },
    PmenuSbar = { fg = c.none, bg = c.bg1 },
    PmenuSel = { fg = c.bg0, bg = c.bg_blue },
    WildMenu = { fg = c.bg0, bg = c.blue },
    PmenuThumb = { fg = c.none, bg = c.grey },
    Question = { fg = c.yellow },
    SpellBad = { fg = c.none, fmt = "undercurl", sp = c.red },
    SpellCap = { fg = c.none, fmt = "undercurl", sp = c.yellow },
    SpellLocal = { fg = c.none, fmt = "undercurl", sp = c.blue },
    SpellRare = { fg = c.none, fmt = "undercurl", sp = c.purple },
    StatusLine = { fg = c.fg, bg = c.bg2, fmt = "none" },
    StatusLineTerm = { fg = c.fg, bg = c.bg2, fmt = "none" },
    StatusLineNC = { fg = c.grey, bg = c.bg1, fmt = "none" },
    StatusLineTermNC = { fg = c.grey, bg = c.bg1, fmt = "none" },
    TabLine = { fg = c.fg, bg = c.bg1 },
    TabLineFill = { fg = c.grey, bg = c.bg1 },
    TabLineSel = { fg = c.bg0, bg = c.fg },
    WinSeparator = { fg = c.bg3 },
    Visual = { bg = c.bg3 },
    VisualNOS = { fg = c.none, bg = c.bg2, fmt = "underline" },
    QuickFixLine = { fg = c.blue, bg = c.bg2, fmt = "bold" },
    Debug = { fg = c.yellow },
    debugPC = { fg = c.bg0, bg = c.green },
    debugBreakpoint = { fg = c.bg0, bg = c.red },
    ToolbarButton = { fg = c.bg0, bg = c.bg_blue },
    FloatBorder = { fg = c.grey, bg = style.transparent and "none" or c.bg1 },
    NormalFloat = { fg = c.fg, bg = style.transparent and "none" or c.bg1 },
    WinBar = { fg = c.fg, bg = bg0 },
    WinBarNC = { fg = c.grey, bg = bg0 },
}

-- Syntax highlights

local syntax = {
    String = { fg = c.green, fmt = style.strings },
    Character = color.Orange,
    Number = color.Orange,
    Float = color.Orange,
    Boolean = color.Orange,
    Type = color.Yellow,
    Structure = color.Yellow,
    StorageClass = color.Yellow,
    Identifier = { fg = c.red, fmt = style.variables },
    Constant = color.Cyan,
    PreProc = color.Purple,
    PreCondit = color.Purple,
    Include = color.Purple,
    Keyword = { fg = c.purple, fmt = style.keywords },
    Define = color.Purple,
    Typedef = color.Yellow,
    Exception = color.Purple,
    Conditional = { fg = c.purple, fmt = style.keywords },
    Repeat = { fg = c.purple, fmt = style.keywords },
    Statement = color.Purple,
    Macro = color.Red,
    Error = color.Purple,
    Label = color.Purple,
    Special = color.Red,
    SpecialChar = color.Red,
    Function = { fg = c.blue, fmt = style.functions },
    Operator = color.Purple,
    Title = color.Cyan,
    Tag = color.Green,
    Delimiter = color.LightGrey,
    Comment = { fg = c.grey, fmt = style.comments },
    SpecialComment = { fg = c.grey, fmt = style.comments },
    Todo = { fg = c.red, fmt = style.comments },
}

-- Treesitter

local treesitter = {
    ["@attribute"] = color.Cyan,
    ["@attribute.builtin"] = color.Blue,
    ["@boolean"] = color.Orange,
    ["@character"] = color.Orange,
    ["@character.special"] = color.Red,
    ["@number"] = color.Orange,
    ["@number.float"] = color.Orange,
    ["@comment"] = { fg = c.grey, fmt = style.comments },
    ["@comment.documentation"] = { fg = c.grey, fmt = style.comments },
    ["@comment.error"] = { fg = c.red, fmt = style.comments },
    ["@comment.note"] = { fg = c.blue, fmt = style.comments },
    ["@comment.todo"] = { fg = c.purple, fmt = style.comments },
    ["@comment.warning"] = { fg = c.yellow, fmt = style.comments },
    ["@constant"] = { fg = c.orange, fmt = style.constants },
    ["@constant.builtin"] = { fg = c.orange, fmt = style.constants },
    ["@constant.macro"] = { fg = c.orange, fmt = style.constants },
    ["@constructor"] = { fg = c.yellow, fmt = "bold" },
    ["@diff.plus"] = color.Green,
    ["@diff.minus"] = color.Red,
    ["@diff.delta"] = color.Blue,
    ["@function"] = { fg = c.blue, fmt = style.functions },
    ["@function.builtin"] = { fg = c.cyan, fmt = style.functions },
    ["@function.call"] = { fg = c.blue, fmt = style.functions },
    ["@function.macro"] = { fg = c.cyan, fmt = style.functions },
    ["@function.method"] = { fg = c.blue, fmt = style.functions },
    ["@function.method.call"] = { fg = c.blue, fmt = style.functions },
    ["@keyword"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.conditional"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.conditional.ternary"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.coroutine"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.debug"] = { fg = c.red, fmt = style.keywords },
    ["@keyword.directive"] = color.Purple,
    ["@keyword.directive.define"] = color.Purple,
    ["@keyword.exception"] = color.Purple,
    ["@keyword.function"] = { fg = c.purple, fmt = style.functions },
    ["@keyword.import"] = color.Purple,
    ["@keyword.modifier"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.operator"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.repeat"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.return"] = { fg = c.purple, fmt = style.keywords },
    ["@keyword.type"] = { fg = c.purple, fmt = style.keywords },
    ["@label"] = color.Red,
    ["@markup.strong"] = { fg = c.fg, fmt = "bold" },
    ["@markup.italic"] = { fg = c.fg, fmt = "italic" },
    ["@markup.strikethrough"] = { fg = c.fg, fmt = "strikethrough" },
    ["@markup.underline"] = { fg = c.fg, fmt = "underline" },
    ["@markup.heading"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.1"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.2"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.3"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.4"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.5"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.6"] = { fg = c.orange, fmt = "bold" },
    ["@markup.link"] = color.Blue,
    ["@markup.link.label"] = color.Cyan,
    ["@markup.link.url"] = { fg = c.cyan, fmt = "underline" },
    ["@markup.list"] = color.Red,
    ["@markup.list.checked"] = { fg = c.green, fmt = style.comments },
    ["@markup.list.unchecked"] = { fg = c.red, fmt = style.comments },
    ["@markup.math"] = color.Fg,
    ["@markup.quote"] = { fg = c.grey, fmt = "italic" },
    ["@markup.raw"] = color.Green,
    ["@markup.raw.block"] = color.Green,
    ["@module"] = color.Yellow,
    ["@module.builtin"] = color.Orange,
    ["@none"] = color.Fg,
    ["@conceal"] = color.Grey,
    ["@operator"] = color.Fg,
    ["@property"] = color.Cyan,
    ["@punctuation.bracket"] = color.LightGrey,
    ["@punctuation.delimiter"] = color.LightGrey,
    ["@punctuation.special"] = color.Red,
    ["@string"] = { fg = c.green, fmt = style.strings },
    ["@string.documentation"] = { fg = c.green, fmt = style.strings },
    ["@string.escape"] = { fg = c.red, fmt = style.strings },
    ["@string.regexp"] = { fg = c.orange, fmt = style.strings },
    ["@string.special"] = { fg = c.dark_cyan, fmt = style.strings },
    ["@string.special.path"] = { fg = c.green, fmt = style.strings },
    ["@string.special.symbol"] = color.Cyan,
    ["@string.special.url"] = { fg = c.cyan, fmt = "underline" },
    ["@tag"] = color.Purple,
    ["@tag.builtin"] = color.Purple,
    ["@tag.attribute"] = color.Yellow,
    ["@tag.delimiter"] = color.Purple,
    ["@type"] = color.Yellow,
    ["@type.builtin"] = color.Orange,
    ["@type.definition"] = color.Yellow,
    ["@variable"] = { fg = c.fg, fmt = style.variables },
    ["@variable.builtin"] = { fg = c.red, fmt = style.variables },
    ["@variable.member"] = color.Cyan,
    ["@variable.parameter"] = color.Red,
    ["@variable.parameter.builtin"] = { fg = c.orange, fmt = style.variables },
}

-- LSP semantic tokens (Neovim 0.9+)

local lsp = {
    ["@lsp.type.comment"] = { fg = c.grey, fmt = style.comments },
    ["@lsp.type.enum"] = color.Yellow,
    ["@lsp.type.enumMember"] = { fg = c.orange, fmt = style.constants },
    ["@lsp.type.interface"] = color.Yellow,
    ["@lsp.type.typeParameter"] = color.Yellow,
    ["@lsp.type.keyword"] = { fg = c.purple, fmt = style.keywords },
    ["@lsp.type.namespace"] = color.Yellow,
    ["@lsp.type.parameter"] = color.Red,
    ["@lsp.type.property"] = color.Cyan,
    ["@lsp.type.variable"] = { fg = c.fg, fmt = style.variables },
    ["@lsp.type.macro"] = { fg = c.cyan, fmt = style.functions },
    ["@lsp.type.method"] = { fg = c.blue, fmt = style.functions },
    ["@lsp.type.number"] = color.Orange,
    ["@lsp.type.generic"] = color.Fg,
    ["@lsp.type.builtinType"] = color.Orange,
    ["@lsp.typemod.method.defaultLibrary"] = { fg = c.blue, fmt = style.functions },
    ["@lsp.typemod.function.defaultLibrary"] = { fg = c.blue, fmt = style.functions },
    ["@lsp.typemod.operator.injected"] = color.Fg,
    ["@lsp.typemod.string.injected"] = { fg = c.green, fmt = style.strings },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = c.red, fmt = style.variables },
    ["@lsp.typemod.variable.injected"] = { fg = c.fg, fmt = style.variables },
    ["@lsp.typemod.variable.static"] = { fg = c.orange, fmt = style.constants },
}

-- Apply all groups

for group, spec in pairs(common) do
    hi(group, spec)
end

for group, spec in pairs(syntax) do
    hi(group, spec)
end

for group, spec in pairs(treesitter) do
    hi(group, spec)
end

for group, spec in pairs(lsp) do
    hi(group, spec)
end

-- Terminal colours

if style.term_colors then
    vim.g.terminal_color_0 = c.black
    vim.g.terminal_color_1 = c.red
    vim.g.terminal_color_2 = c.green
    vim.g.terminal_color_3 = c.yellow
    vim.g.terminal_color_4 = c.blue
    vim.g.terminal_color_5 = c.purple
    vim.g.terminal_color_6 = c.cyan
    vim.g.terminal_color_7 = c.fg
    vim.g.terminal_color_8 = c.grey
    vim.g.terminal_color_9 = c.red
    vim.g.terminal_color_10 = c.green
    vim.g.terminal_color_11 = c.yellow
    vim.g.terminal_color_12 = c.blue
    vim.g.terminal_color_13 = c.purple
    vim.g.terminal_color_14 = c.cyan
    vim.g.terminal_color_15 = c.fg
end
