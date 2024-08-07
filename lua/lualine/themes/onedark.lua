local c = require("onedark.colors")
local cfg = vim.g.onedark_config
local colors = {
	bg = c.bg0,
	fg = c.fg,
	red = c.red,
	green = c.green,
	yellow = c.yellow,
	blue = c.blue,
	purple = c.purple,
	cyan = c.cyan,
	gray = c.grey,
}

local one_dark = {
	inactive = {
		a = { fg = colors.gray, bg = colors.bg, gui = "bold" },
		b = { fg = colors.gray, bg = c.transparent_grey },
		c = {
			fg = colors.gray,
			bg = cfg.lualine.transparent and c.none or c.black,
		},
	},
	normal = {
		a = { fg = colors.bg, bg = colors.green, gui = "bold" },
		b = { fg = colors.fg, bg = c.transparent_grey },
		c = { fg = colors.fg, bg = cfg.lualine.transparent and c.none or c.black },
		-- c = {fg = colors.fg, bg = cfg.lualine.transparent and c.none or c.red},
	},
	visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
	replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
	insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
	command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
	terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
}
return one_dark
