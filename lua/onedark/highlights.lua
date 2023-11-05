local c = require("onedark.colors")

local cfg = vim.g.onedark_config
local util = require("onedark.util")

local M = {}
local hl = { langs = {}, plugins = {} }

local function vim_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group_name,
				group_settings.fg or "none",
				group_settings.bg or "none",
				group_settings.sp or "none",
				group_settings.fmt or "none"
			)
		)
	end
end

local colors = {
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
	white = { fg = c.white },
}
hl.common = {
	Normal = { fg = c.white_bright, bg = cfg.transparent and c.none or c.black },
	Terminal = { fg = c.black, bg = cfg.transparent and c.none or c.black },
	EndOfBuffer = {
		fg = cfg.ending_tildes and c.black or c.black,
		bg = cfg.transparent and c.black or c.black,
	},
	FoldColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
	Folded = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
	SignColumn = { fg = c.black, bg = cfg.transparent and c.none or c.black },
	ToolbarLinek = { fg = c.fg },
	TermCursor = { bg = c.fg, fg = c.blue, fmt = "reverse" },
	Cursor = { fmt = "reverse" },
	vCursor = { fmt = "reverse" },
	iCursor = { fmt = "reverse" },
	lCursor = { fmt = "reverse" },
	CursorIM = { fmt = "reverse" },
	CursorColumn = { bg = c.bg1 },
	CursorLine = { bg = c.black },
	ColorColumn = { bg = c.black },
	CursorLineNr = { fg = c.blue, fmt = "bold" },
	LineNr = { fg = c.grey },
	Conceal = { fg = c.grey, bg = c.bg1 },
	DiffAdd = { fg = c.red, bg = c.black },
	DiffChange = { fg = c.none, bg = c.diff_change },
	DiffDelete = { fg = c.none, bg = c.diff_delete },
	DiffText = { fg = c.none, bg = c.diff_text },
	DiffAdded = colors.Green,
	DiffRemoved = colors.Red,
	DiffFile = colors.Cyan,
	DiffIndexLine = colors.Grey,
	Directory = { fg = c.blue },
	ErrorMsg = { fg = c.red, fmt = "bold" },
	WarningMsg = { fg = c.yellow, fmt = "bold" },
	MoreMsg = { fg = c.blue, fmt = "bold" },
	CurSearch = { fg = c.bg0, bg = c.Charm_Pink },
	IncSearch = { fg = c.black, bg = c.orange },
	Search = { fg = c.Davys_Grey, bg = c.TeaGreen, fmt = "bold" },
	Substitute = { fg = c.bg0, bg = c.green },
	MatchParen = { fg = c.none, bg = c.grey },
	NonText = { fg = c.grey },
	Whitespace = { fg = c.grey },
	SpecialKey = { fg = c.grey },
	Pmenu = { fg = c.fg, bg = c.black },
	PmenuSbar = { fg = c.none, bg = c.bg1 },
	PmenuSel = { fg = c.bg0, bg = c.bg_blue },
	WildMenu = { fg = c.bg0, bg = c.blue },
	PmenuThumb = { fg = c.none, bg = c.blue },
	Question = { fg = c.yellow },
	SpellBad = { fg = c.red, fmt = "underline", sp = c.red },
	SpellCap = { fg = c.yellow, fmt = "underline", sp = c.yellow },
	SpellLocal = { fg = c.blue, fmt = "underline", sp = c.blue },
	SpellRare = { fg = c.purple, fmt = "underline", sp = c.purple },
	StatusLine = { fg = c.fg, bg = c.bg2 },
	StatusLineTerm = { fg = c.black, bg = c.black },
	StatusLineNC = { fg = c.grey, bg = c.bg1 },
	StatusLineTermNC = { fg = c.black, bg = c.black },
	TabLine = { fg = c.black, bg = c.black },
	TabLineFill = { fg = c.black, bg = c.black },
	TabLineSel = { fg = c.bg0, bg = c.black },
	VertSplit = { fg = c.blue, bg = c.black },
	Visual = { fg = c.Davys_Grey, bg = c.Charm_Pink, fmt = "bold" },
	VisualNOS = { fg = c.none, bg = c.bg2, fmt = "underline" },
	QuickFixLine = { fg = c.blue, fmt = "underline" },
	Debug = { fg = c.yellow },
	debugPC = { fg = c.black, bg = c.green },
	debugBreakpoint = { fg = c.black, bg = c.red },
	ToolbarButton = { fg = c.black, bg = c.bg_blue },
	FloatBorder = { fg = c.white, bg = c.black },
	NormalFloat = { fg = c.fg, bg = c.black },
	-- Added colortheme
	TextYankPost_style = { fg = c.black, bg = c.light_orange, fmt = "bold" },
	Floaterm = { fg = c.black, bg = c.black }, -- terminal color for nvim
	FidgetTitle = { fg = c.Charm_Pink, bg = c.Blush },
}

hl.syntax = {
	String = { fg = c.light_blue, fmt = cfg.code_style.strings },
	Character = colors.Orange,
	Number = colors.Blue,
	Float = colors.Blue,
	Boolean = colors.Blue,
	Type = colors.Orange,
	Structure = colors.Orange, -- This will highlight all the use something::something in rust <realated to namespace>
	StorageClass = colors.Orange,
	Identifier = { fg = c.fg, fmt = cfg.code_style.variables }, -- Ghasak Note: this is the variable color
	Constant = { fg = c.Light_Yellow },
	PreProc = colors.Purple,
	PreCondit = colors.Purple,
	Include = colors.Red,
	Keyword = { fg = c.red, fmt = cfg.code_style.keywords }, -- for, let , if ..etc.
	Define = colors.Purple,
	Typedef = colors.Purple,
	Exception = colors.Purple,
	Conditional = { fg = c.red, fmt = cfg.code_style.keywords },
	Repeat = { fg = c.red, fmt = cfg.code_style.keywords },
	Statement = colors.Purple,
	Macro = colors.Purple,
	Error = colors.Purple,
	Label = colors.Purple,
	Special = colors.Red,
	SpecialChar = colors.Red,
	Function = { fg = c.blue, fmt = cfg.code_style.functions }, -- this for function.call
	Operator = colors.Red,
	Title = colors.Blue,
	Tag = colors.Green,
	Delimiter = colors.LightGrey,
	Comment = { fg = c.light_grey_comment, fmt = cfg.code_style.comments },
	SpecialComment = { fg = c.grey, fmt = cfg.code_style.comments },
	Todo = { fg = c.red, fmt = cfg.code_style.comments },
}

if vim.api.nvim_call_function("has", { "nvim-0.9" }) == 1 then
	hl.treesitter = {
		["@annotation"] = colors.Fg,
		["@attribute"] = { fg = c.purple }, -- such as decorators
		["@attribute.typescript"] = colors.Blue,
		["@boolean"] = colors.Blue,
		["@character"] = colors.Orange,
		["@comment"] = {
			fg = c.light_grey_comment,
			fmt = cfg.code_style.comments,
		},
		["@conditional"] = { fg = c.red, fmt = cfg.code_style.keywords },
		["@constant"] = { fg = c.Light_Yellow },
		["@constant.builtin"] = colors.Light_Yellow,
		["@constant.macro"] = colors.Light_Yellow,
		["@constructor"] = { fg = c.purple_e, fmt = "bold" },
		["@error"] = colors.Fg,
		["@exception"] = colors.Purple,
		["@field"] = { fg = c.fg },
		["@float"] = colors.Blue,
		["@function"] = { fg = c.blue, fmt = cfg.code_style.functions },
		["@function.builtin"] = { fg = c.blue, fmt = cfg.code_style.functions },
		["@function.macro"] = { fg = c.purple_e, fmt = cfg.code_style.functions },
		["@function.call"] = { fg = c.blue, fmt = cfg.code_style.functions }, -- this was not inlcuded
		["@method.call"] = { fg = c.blue, fmt = cfg.code_style.functions }, -- this was not inlcuded
		["@include"] = colors.red,
		["@keyword"] = { fg = c.red, fmt = cfg.code_style.keywords },
		["@keyword.function"] = { fg = c.red, fmt = cfg.code_style.functions },
		["@keyword.operator"] = { fg = c.red, fmt = cfg.code_style.keywords },
		["@label"] = colors.Red,
		["@method"] = c.purple_e,
		["@namespace"] = { fg = c.orange },
		["@none"] = colors.Fg,
		["@number"] = colors.Blue,
		["@operator"] = colors.Red,
		["@parameter"] = { fg = c.fg }, -- colors.Red,
		["@parameter.reference"] = colors.Fg,
		-- ["@property"] = colors.Cyan,
		["@property"] = colors.Fg,
		["@punctuation.delimiter"] = colors.LightGrey,
		["@punctuation.bracket"] = colors.LightGrey,
		["@punctuation.special"] = colors.Red,
		["@repeat"] = { fg = c.red, fmt = cfg.code_style.keywords },
		["@string"] = { fg = c.light_blue, fmt = cfg.code_style.strings },
		["@string.regex"] = { fg = c.orange, fmt = cfg.code_style.strings },
		["@string.escape"] = { fg = c.red, fmt = cfg.code_style.strings },
		["@symbol"] = colors.Red,
		["@tag"] = colors.Purple,
		["@tag.attribute"] = colors.Yellow,
		["@tag.delimiter"] = colors.Purple,
		["@text"] = colors.Fg,
		["@text.strong"] = { fg = c.fg, fmt = "bold" },
		["@text.emphasis"] = { fg = c.fg, fmt = "italic" },
		["@text.underline"] = { fg = c.fg, fmt = "underline" },
		["@text.strike"] = { fg = c.fg, fmt = "strikethrough" },
		["@text.literal"] = c.mimi_pink,
		["@text.uri"] = { fg = c.light_blue, fmt = "underline" }, -- for hyperlinks
		["@text.todo"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@text.math"] = colors.Fg,
		["@text.reference"] = colors.Blue,
		["@text.environment"] = colors.Fg,
		["@text.environment.name"] = colors.Fg,
		["@text.diff.add"] = colors.Green,
		["@text.diff.delete"] = colors.Red,
		["@note"] = colors.Fg,
		["@warning"] = colors.Fg,
		["@danger"] = colors.Fg,
		["@type"] = colors.Yellow,
		["@type.builtin"] = colors.Yellow,
		["@variable"] = { fg = c.fg, fmt = cfg.code_style.variables },
		["@variable.builtin"] = { fg = c.fg, fmt = cfg.code_style.variables },
		-- for markdown heading
		["@text.title"] = { fg = c.amaranth_pink, bg = c.github_symbol, fmt = "bold" },
		["@text.title.2"] = { fg = c.purple, bg = c.github_symbol, fmt = "bold" },
		["@text.title.3"] = { fg = c.cool_gray, bg = c.github_symbol, fmt = "bold" },
		["@text.title.4"] = { fg = c.blue, bg = c.github_symbol, fmt = "bold" },
		["@text.title.5"] = { fg = c.amaranth_pink, bg = c.github_symbol, fmt = "bold" },
		["@text.title.6"] = { fg = c.orange, bg = c.github_symbol, fmt = "bold" },
	}
else
	hl.treesitter = {
		TSAnnotation = colors.Fg,
		TSAttribute = colors.Cyan,
		TSBoolean = colors.Blue,
		TSCharacter = colors.Fg,
		TSComment = { fg = c.grey, fmt = cfg.code_style.comments },
		TSConditional = { fg = c.red, fmt = cfg.code_style.keywords },
		TSConstant = colors.Yellow,
		TSConstBuiltin = colors.Fg,
		TSConstMacro = colors.Fg,
		TSConstructor = { fg = c.purple_e, fmt = "bold" },
		TSError = colors.Fg,
		TSException = colors.Purple,
		TSField = { fg = c.fg }, -- colors.Cyan,
		TSFloat = colors.Blue,
		TSFunction = { fg = c.purple_e, fmt = cfg.code_style.functions },
		TSFuncBuiltin = { fg = c.purple_e, fmt = cfg.code_style.functions },
		TSFuncMacro = { fg = c.purple_e, fmt = cfg.code_style.functions },
		TSInclude = colors.Red,
		TSKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
		TSKeywordFunction = { fg = c.purple, fmt = cfg.code_style.functions },
		TSKeywordOperator = { fg = c.purple, fmt = cfg.code_style.keywords },
		TSLabel = colors.Red,
		TSMethod = colors.Blue,
		TSNamespace = colors.Orange,
		TSNone = colors.Fg,
		TSNumber = colors.Orange,
		TSOperator = colors.Red,
		TSParameter = { fg = c.fg }, -- colors.Red,
		TSParameterReference = colors.Fg,
		TSProperty = colors.Cyan,
		TSPunctDelimiter = colors.LightGrey,
		TSPunctBracket = colors.LightGrey,
		TSPunctSpecial = colors.Red,
		TSRepeat = { fg = c.red, fmt = cfg.code_style.keywords },
		TSString = { fg = c.green, fmt = cfg.code_style.strings },
		TSStringRegex = { fg = c.orange, fmt = cfg.code_style.strings },
		TSStringEscape = { fg = c.red, fmt = cfg.code_style.strings },
		TSSymbol = colors.Cyan,
		TSTag = colors.Purple,
		TSTagDelimiter = colors.Purple,
		TSText = colors.Fg,
		TSStrong = { fg = c.fg, fmt = "bold" },
		TSEmphasis = { fg = c.fg, fmt = "italic" },
		TSUnderline = { fg = c.fg, fmt = "underline" },
		TSStrike = { fg = c.fg, fmt = "strikethrough" },
		TSTitle = { fg = c.orange, fmt = "bold" },
		TSLiteral = colors.Green,
		TSURI = { fg = c.cyan, fmt = "underline" },
		TSMath = colors.Fg,
		TSTextReference = colors.Blue,
		TSEnvironment = colors.Fg,
		TSEnvironmentName = colors.Fg,
		TSNote = colors.Fg,
		TSWarning = colors.Fg,
		TSDanger = colors.Fg,
		TSType = colors.Yellow,
		TSTypeBuiltin = colors.Yellow,
		TSVariable = { fg = c.fg, fmt = cfg.code_style.variables },
		TSVariableBuiltin = { fg = c.fg, fmt = cfg.code_style.variables },
	}
end

---@diagnostic disable-next-line: unused-local
local diagnostics_error_color = cfg.diagnostics.darker and c.dark_red or c.red
---@diagnostic disable-next-line: unused-local
local diagnostics_hint_color = cfg.diagnostics.darker and c.dark_purple or c.purple
---@diagnostic disable-next-line: unused-local
local diagnostics_warn_color = cfg.diagnostics.darker and c.dark_yellow or c.yellow
---@diagnostic disable-next-line: unused-local
local diagnostics_info_color = cfg.diagnostics.darker and c.dark_cyan or c.cyan

hl.plugins.lsp = {
	LspCxxHlGroupEnumConstant = colors.Orange,
	LspCxxHlGroupMemberVariable = colors.Orange,
	LspCxxHlGroupNamespace = colors.Blue,
	LspCxxHlSkippedRegion = colors.Grey,
	LspCxxHlSkippedRegionBeginEnd = colors.Red,

	DiagnosticError = { fg = c.light_Fiery_Rose },
	DiagnosticHint = { fg = c.Buff },
	DiagnosticInfo = { fg = c.bright_navy_blue },
	DiagnosticWarn = { fg = c.apricot },

	DiagnosticVirtualTextError = { bg = c.black, fg = c.light_Fiery_Rose },
	-- DiagnosticVirtualTextError = {
	--     bg = cfg.diagnostics.background and
	--         util.darken(diagnostics_error_color, 0.1, c.bg0) or c.black,
	--     fg =c.light_Fierry_Rose
	-- },
	DiagnosticVirtualTextWarn = { bg = c.black, fg = c.apricot },
	-- DiagnosticVirtualTextWarn = {
	--     bg = cfg.diagnostics.background and
	--         util.darken(diagnostics_warn_color, 0.1, c.bg0) or c.black,
	--     fg =c.apricot
	-- },
	DiagnosticVirtualTextInfo = { bg = c.black, fg = c.birght_navy_blue },
	-- DiagnosticVirtualTextInfo = {
	--     bg = cfg.diagnostics.background and
	--         util.darken(diagnostics_info_color, 0.1, c.bg0) or c.black,
	--     fg = c.bright_navy_blue
	-- },

	DiagnosticVirtualTextHint = { bg = c.black, fg = c.Buff },
	-- DiagnosticVirtualTextHint = {
	--     bg = cfg.diagnostics.background and
	--         util.darken(diagnostics_hint_color, 0.1, c.bg0) or c.black,
	--     fg = c.cadet_Grey
	-- },

	DiagnosticUnderlineError = {
		fmt = cfg.diagnostics.undercurl and "undercurl" or "underline",
		sp = c.red,
	},
	DiagnosticUnderlineHint = {
		fmt = cfg.diagnostics.undercurl and "undercurl" or "underline",
		sp = c.purple,
	},
	DiagnosticUnderlineInfo = {
		fmt = cfg.diagnostics.undercurl and "undercurl" or "underline",
		sp = c.blue,
	},
	DiagnosticUnderlineWarn = {
		fmt = cfg.diagnostics.undercurl and "undercurl" or "underline",
		sp = c.yellow,
	},

	LspReferenceText = { bg = c.bg2 },
	LspReferenceWrite = { bg = c.bg2 },
	LspReferenceRead = { bg = c.bg2 },

	LspCodeLens = { fg = c.grey, fmt = cfg.code_style.comments },
	LspCodeLensSeparator = { fg = c.grey },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.ale = {
	ALEErrorSign = hl.plugins.lsp.DiagnosticError,
	ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
	ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
	BufferCurrent = { fmt = "bold" },
	BufferCurrentMod = { fg = c.black, fmt = "bold,italic" },
	BufferCurrentSign = { fg = c.black, bg = c.black },
	BufferInactiveMod = { fg = c.light_grey, bg = c.black, fmt = "italic" },
	BufferVisible = { fg = c.light_grey, bg = c.black },
	BufferVisibleMod = { fg = c.yellow, bg = c.black, fmt = "italic" },
	BufferVisibleIndex = { fg = c.light_grey, bg = c.black },
	BufferVisibleSign = { fg = c.light_grey, bg = c.black },
	BufferVisibleTarget = { fg = c.light_grey, bg = c.black },
}

hl.plugins.cmp = {
	CmpItemAbbr = colors.Fg,
	CmpItemAbbrDeprecated = { fg = c.light_grey, fmt = "strikethrough" },
	CmpItemAbbrMatch = colors.Cyan,
	CmpItemAbbrMatchFuzzy = { fg = c.cyan, fmt = "underline" },
	CmpItemMenu = colors.LightGrey,
	CmpItemKind = { fg = c.purple, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.coc = {
	CocErrorSign = hl.plugins.lsp.DiagnosticError,
	CocHintSign = hl.plugins.lsp.DiagnosticHint,
	CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
	CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
	WhichKey = colors.Red,
	WhichKeyDesc = colors.Blue,
	WhichKeyGroup = colors.Orange,
	WhichKeySeparator = colors.Green,
}

hl.plugins.gitgutter = {
	GitGutterAdd = { fg = c.green },
	GitGutterChange = { fg = c.blue },
	GitGutterDelete = { fg = c.red },
}

hl.plugins.hop = {
	HopNextKey = { fg = c.red, fmt = "bold" },
	HopNextKey1 = { fg = c.cyan, fmt = "bold" },
	HopNextKey2 = { fg = util.darken(c.blue, 0.7) },
	HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = c.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = c.purple, fmt = "bold" },
	DiffviewFilePanelFileName = colors.Fg,
	DiffviewNormal = hl.common.Normal,
	DiffviewCursorLine = hl.common.CursorLine,
	DiffviewVertSplit = { fg = c.light_green, bf = c.black },
	DiffviewSignColumn = hl.common.SignColumn,
	DiffviewStatusLine = hl.common.StatusLine,
	DiffviewStatusLineNC = hl.common.StatusLineNC,
	DiffviewEndOfBuffer = hl.common.EndOfBuffer,
	DiffviewFilePanelRootPath = colors.Grey,
	DiffviewFilePanelPath = colors.Grey,
	DiffviewFilePanelInsertions = { fg = c.light_green, bf = c.black },
	DiffviewFilePanelDeletions = colors.Red,
	DiffviewStatusAdded = { fg = c.light_green, bf = c.black },
	DiffviewStatusUntracked = colors.Blue,
	DiffviewStatusModified = colors.Blue,
	DiffviewStatusRenamed = colors.Blue,
	DiffviewStatusCopied = colors.Blue,
	DiffviewStatusTypeChange = colors.Blue,
	DiffviewStatusUnmerged = colors.Blue,
	DiffviewStatusUnknown = colors.Red,
	DiffviewStatusDeleted = colors.Red,
	DiffviewStatusBroken = colors.Red,
}

hl.plugins.gitsigns = {
	GitSignsAdd = c.blue,
	GitSignsAddLn = c.blue,
	GitSignsAddNr = c.blue,
	GitSignsChange = colors.Blue,
	GitSignsChangeLn = colors.Blue,
	GitSignsChangeNr = colors.Blue,
	GitSignsDelete = colors.Red,
	GitSignsDeleteLn = colors.Red,
	GitSignsDeleteNr = colors.Red,
}

hl.plugins.neo_tree = {
	NeoTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeVertSplit = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
	NeoTreeWinSeparator = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
	NeoTreeEndOfBuffer = {
		fg = cfg.ending_tildes and c.bg2 or c.bg_d,
		bg = cfg.transparent and c.none or c.bg_d,
	},
	NeoTreeRootName = { fg = c.orange, fmt = "bold" },
	NeoTreeGitAdded = colors.Blue,
	NeoTreeGitDeleted = colors.Red,
	NeoTreeGitModified = colors.Yellow,
	NeoTreeGitConflict = { fg = c.red, fmt = "bold,italic" },
	NeoTreeGitUntracked = { fg = c.red, fmt = "italic" },
	NeoTreeIndentMarker = colors.Grey,
	NeoTreeSymbolicLinkTarget = colors.Purple,
}

hl.plugins.neotest = {
	NeotestAdapterName = { fg = c.purple, fmt = "bold" },
	NeotestDir = colors.Cyan,
	NeotestExpandMarker = colors.Grey,
	NeotestFailed = colors.Red,
	NeotestFile = colors.Cyan,
	NeotestFocused = { fmt = "bold,italic" },
	NeotestIndent = colors.Grey,
	NeotestMarked = { fg = c.orange, fmt = "bold" },
	NeotestNamespace = colors.Blue,
	NeotestPassed = colors.Green,
	NeotestRunning = colors.Yellow,
	NeotestWinSelect = { fg = c.cyan, fmt = "bold" },
	NeotestSkipped = colors.LightGrey,
	NeotestTarget = colors.Purple,
	NeotestTest = colors.Fg,
	NeotestUnknown = colors.LightGrey,
}

hl.plugins.nvim_tree = {
	NvimTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.black },
	NvimTreeVertSplit = {
		fg = c.white,
		bg = cfg.transparent and c.none or c.black,
	},
	NvimTreeEndOfBuffer = {
		fg = cfg.ending_tildes and c.bg2 or c.white,
		bg = cfg.transparent and c.none or c.black,
	},
	NvimTreeRootFolder = { fg = c.orange, fmt = "bold" },
	NvimTreeGitDirty = colors.Yellow,
	NvimTreeGitNew = { fg = c.white, bg = c.black },
	NvimTreeGitDeleted = colors.Red,
	NvimTreeSpecialFile = { fg = c.yellow, fmt = "underline" },
	NvimTreeIndentMarker = colors.Fg,
	NvimTreeImageFile = { fg = c.purple_e },
	NvimTreeSymlink = c.purple_e,
	NvimTreeFolderName = c.blue,
	NvimTreeBookmark = { fg = c.blue },
}
hl.plugins.telescope = {
	TelescopeBorder = { fg = c.white },
	TelescopePromptBorder = { fg = c.white },
	TelescopeResultsBorder = { fg = c.white },
	TelescopePreviewBorder = { fg = c.white },
	-- TelescopeMatching = {fg = c.orange, fmt = "bold"},
	-- TelescopePromptPrefix = colors.Green,
	-- TelescopeSelection = {bg = c.bg2},
	TelescopeSelectionCaret = colors.Yellow,
	TelescopeTitle = { fg = c.red, fmt = "bold" },
	TelescopeMatching = { fg = c.red, fmt = "bold" },
	TelescopePromptPrefix = { fg = c.blue },
	TelescopeSelection = { fg = c.blue, fmt = "bold" },
}

hl.plugins.dashboard = {
	DashboardShortCut = colors.Blue,
	DashboardHeader = colors.Yellow,
	DashboardCenter = colors.Cyan,
	DashboardFooter = { fg = c.dark_red, fmt = "italic" },
}

hl.plugins.outline = {
	FocusedSymbol = { fg = c.purple, bg = c.bg2, fmt = "bold" },
	AerialLine = { fg = c.purple, bg = c.bg2, fmt = "bold" },
}

hl.plugins.navic = {
	NavicText = { fg = c.fg },
	NavicSeparator = { fg = c.light_grey },
}

hl.plugins.ts_rainbow = {

	rainbowcol1 = colors.Fg,
	rainbowcol2 = colors.Yellow,
	rainbowcol3 = colors.Blue,
	rainbowcol4 = colors.Orange,
	rainbowcol5 = colors.Purple,
	rainbowcol6 = colors.Green,
	rainbowcol7 = colors.Red,
}

hl.plugins.indent_blankline = {

	IndentBlanklineIndent1 = { fg = c.blue, bg = c.fg },
	IndentBlanklineIndent2 = { fg = c.blue, bg = c.fg },
	IndentBlanklineIndent3 = { fg = c.blue, bg = c.fg },
	IndentBlanklineIndent4 = { fg = c.blue, bg = c.fg },
	IndentBlanklineIndent5 = { fg = c.blue, bg = c.fg },
	IndentBlanklineIndent6 = { fg = c.blue, bg = c.fg },
	IndentBlanklineChar = { fg = c.bg1, gui = "nocombine" },
	IndentBlanklineContext = { fg = c.orange, bg = c.grey, bold = true },
	IndentBlanklineContextChar = { fg = c.grey, gui = "nocombine" },
	IndentBlanklineContextStart = { sp = c.grey, gui = "underline" },
	IndentBlanklineContextSpaceChar = { gui = "nocombine" },
}

hl.plugins.mini = {
	MiniCompletionActiveParameter = { fmt = "underline" },

	MiniCursorword = { fmt = "underline" },
	MiniCursorwordCurrent = { fmt = "underline" },

	MiniIndentscopeSymbol = { fg = c.grey },
	MiniIndentscopePrefix = { fmt = "nocombine" }, -- Make it invisible

	MiniJump = { fg = c.purple, fmt = "underline", sp = c.purple },

	MiniJump2dSpot = { fg = c.red, fmt = "bold,nocombine" },

	MiniStarterCurrent = { fmt = "nocombine" },
	MiniStarterFooter = { fg = c.dark_red, fmt = "italic" },
	MiniStarterHeader = colors.Yellow,
	MiniStarterInactive = { fg = c.grey, fmt = cfg.code_style.comments },
	MiniStarterItem = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
	MiniStarterItemBullet = { fg = c.grey },
	MiniStarterItemPrefix = { fg = c.yellow },
	MiniStarterSection = colors.LightGrey,
	MiniStarterQuery = { fg = c.cyan },

	MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg2 },
	MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg2 },
	MiniStatuslineFilename = { fg = c.grey, bg = c.bg1 },
	MiniStatuslineInactive = { fg = c.grey, bg = c.bg0 },
	MiniStatuslineModeCommand = { fg = c.bg0, bg = c.yellow, fmt = "bold" },
	MiniStatuslineModeInsert = { fg = c.bg0, bg = c.blue, fmt = "bold" },
	MiniStatuslineModeNormal = { fg = c.bg0, bg = c.green, fmt = "bold" },
	MiniStatuslineModeOther = { fg = c.bg0, bg = c.cyan, fmt = "bold" },
	MiniStatuslineModeReplace = { fg = c.bg0, bg = c.red, fmt = "bold" },
	MiniStatuslineModeVisual = { fg = c.bg0, bg = c.purple, fmt = "bold" },

	MiniSurround = { fg = c.bg0, bg = c.orange },

	MiniTablineCurrent = { fmt = "bold" },
	MiniTablineFill = { fg = c.grey, bg = c.bg1 },
	MiniTablineHidden = { fg = c.fg, bg = c.bg1 },
	MiniTablineModifiedCurrent = { fg = c.orange, fmt = "bold,italic" },
	MiniTablineModifiedHidden = { fg = c.light_grey, bg = c.bg1, fmt = "italic" },
	MiniTablineModifiedVisible = { fg = c.yellow, bg = c.bg0, fmt = "italic" },
	MiniTablineTabpagesection = { fg = c.bg0, bg = c.bg_yellow },
	MiniTablineVisible = { fg = c.light_grey, bg = c.bg0 },

	MiniTestEmphasis = { fmt = "bold" },
	MiniTestFail = { fg = c.red, fmt = "bold" },
	MiniTestPass = { fg = c.green, fmt = "bold" },

	MiniTrailspace = { bg = c.red },
}

hl.langs.c = {
	cInclude = colors.Blue,
	cStorageClass = colors.Purple,
	cTypedef = colors.Purple,
	cDefine = colors.Cyan,
	cTSInclude = colors.Blue,
	cTSConstant = colors.Cyan,
	cTSConstMacro = colors.Purple,
	cTSOperator = colors.Purple,
}

hl.langs.cpp = {
	cppStatement = { fg = c.purple, fmt = "bold" },
	cppTSInclude = colors.Blue,
	cppTSConstant = colors.Cyan,
	cppTSConstMacro = colors.Purple,
	cppTSOperator = colors.Purple,
}
-- Overwritten by treesitter
hl.langs.markdown = {
	markdownBlockquote = colors.Grey,
	markdownBold = { fg = c.none, fmt = "bold" },
	markdownBoldDelimiter = colors.Grey,
	markdownCode = { fg = c.light_green, bg = c.github_symbol, fmt = "bold" },
	markdownCodeBlock = colors.Green,
	markdownCodeDelimiter = colors.Yellow,
	markdownH1 = { fg = c.red, fmt = "bold" },
	markdownH2 = { fg = c.purple, fmt = "bold" },
	markdownH3 = { fg = c.orange, fmt = "bold" },
	markdownH4 = { fg = c.red, fmt = "bold" },
	markdownH5 = { fg = c.purple, fmt = "bold" },
	markdownH6 = { fg = c.orange, fmt = "bold" },
	markdownHeadingDelimiter = colors.Grey,
	markdownHeadingRule = colors.Grey,
	markdownId = colors.Yellow,
	markdownIdDeclaration = colors.Red,
	markdownItalic = { fg = c.none, fmt = "italic" },
	markdownItalicDelimiter = { fg = c.grey, fmt = "italic" },
	markdownLinkDelimiter = colors.Grey,
	markdownLinkText = colors.Red,
	markdownLinkTextDelimiter = colors.Grey,
	markdownListMarker = colors.Red,
	markdownOrderedListMarker = colors.Red,
	markdownRule = colors.Purple,
	markdownUrl = { fg = c.blue, fmt = "underline" },
	markdownUrlDelimiter = colors.Grey,
	markdownUrlTitleDelimiter = { fg = c.amaranth_pink, fmt = "bold" },
}

hl.langs.php = {
	phpFunctions = { fg = c.fg, fmt = cfg.code_style.functions },
	phpMethods = colors.Cyan,
	phpStructure = colors.Purple,
	phpOperator = colors.Purple,
	phpMemberSelector = colors.Fg,
	phpVarSelector = { fg = c.orange, fmt = cfg.code_style.variables },
	phpIdentifier = { fg = c.orange, fmt = cfg.code_style.variables },
	phpBoolean = colors.Cyan,
	phpNumber = colors.Orange,
	phpHereDoc = colors.Green,
	phpNowDoc = colors.Green,
	phpSCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	phpFCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	phpRegion = colors.Blue,
}

hl.langs.scala = {
	scalaNameDefinition = colors.Fg,
	scalaInterpolationBoundary = colors.Purple,
	scalaInterpolation = colors.Purple,
	scalaTypeOperator = colors.Red,
	scalaOperator = colors.Red,
	scalaKeywordModifier = { fg = c.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
	latexTSInclude = colors.Blue,
	latexTSFuncMacro = { fg = c.fg, fmt = cfg.code_style.functions },
	latexTSEnvironment = { fg = c.cyan, fmt = "bold" },
	latexTSEnvironmentName = colors.Yellow,
	texCmdEnv = colors.Cyan,
	texEnvArgName = colors.Yellow,
	latexTSTitle = colors.Green,
	latexTSType = colors.Blue,
	latexTSMath = colors.Orange,
	texMathZoneX = colors.Orange,
	texMathZoneXX = colors.Orange,
	texMathDelimZone = colors.LightGrey,
	texMathDelim = colors.Purple,
	texMathOper = colors.Red,
	texCmd = colors.Purple,
	texCmdPart = colors.Blue,
	texCmdPackage = colors.Blue,
	texPgfType = colors.Yellow,
}

hl.langs.vim = {
	vimOption = colors.Red,
	vimSetEqual = colors.Yellow,
	vimMap = colors.Purple,
	vimMapModKey = colors.Orange,
	vimNotation = colors.Red,
	vimMapLhs = colors.Fg,
	vimMapRhs = colors.Blue,
	vimVar = { fg = c.fg, fmt = cfg.code_style.variables },
	vimCommentTitle = { fg = c.light_grey, fmt = cfg.code_style.comments },
}

local lsp_kind_icons_color = {
	Default = c.purple,
	Array = c.yellow,
	Boolean = c.orange,
	Class = c.yellow,
	Color = c.green,
	Constant = c.orange,
	Constructor = c.blue,
	Enum = c.purple,
	EnumMember = c.yellow,
	Event = c.yellow,
	Field = c.fg,
	File = c.blue,
	Folder = c.orange,
	Function = c.blue,
	Interface = c.green,
	Key = c.cyan,
	Keyword = c.cyan,
	Method = c.blue,
	Module = c.orange,
	Namespace = c.red,
	Null = c.grey,
	Number = c.orange,
	Object = c.red,
	Operator = c.red,
	Package = c.yellow,
	Property = c.cyan,
	Reference = c.orange,
	Snippet = c.red,
	String = c.GBLUE_STRING,
	Struct = c.purple,
	Text = c.light_grey,
	TypeParameter = c.red,
	Unit = c.green,
	Value = c.orange,
	Variable = c.purple,
}

function M.setup()
	-- define cmp and aerial kind highlights with lsp_kind_icons_color
	for kind, color in pairs(lsp_kind_icons_color) do
		hl.plugins.cmp["CmpItemKind" .. kind] = {
			fg = color,
			fmt = cfg.cmp_itemkind_reverse and "reverse",
		}
		hl.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
		hl.plugins.navic["NavicIcons" .. kind] = { fg = color }
	end

	vim_highlights(hl.common)
	vim_highlights(hl.syntax)
	vim_highlights(hl.treesitter)
	for _, group in pairs(hl.langs) do
		vim_highlights(group)
	end
	for _, group in pairs(hl.plugins) do
		vim_highlights(group)
	end

	-- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
	local function replace_color(prefix, color_name)
		if not color_name then
			return ""
		end
		if color_name:sub(1, 1) == "$" then
			local name = color_name:sub(2, -1)
			color_name = c[name]
			if not color_name then
				vim.schedule(function()
					vim.notify(
						'onedark.nvim: unknown color "' .. name .. '"',
						vim.log.levels.ERROR,
						{ title = "onedark.nvim" }
					)
				end)
				return ""
			end
		end
		return prefix .. "=" .. color_name
	end

	for group_name, group_settings in pairs(vim.g.onedark_config.highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s %s %s %s %s",
				group_name,
				replace_color("guifg", group_settings.fg),
				replace_color("guibg", group_settings.bg),
				replace_color("guisp", group_settings.sp),
				replace_color("gui", group_settings.fmt)
			)
		)
	end
end

return M
