local M = {}
local cfg = vim.g.onedark_config
local c = require 'onedark.colors'
local light = cfg.style == 'glight' -- c.black is the editor bg and c.fg the text, so ANSI black/white swap on light

function M.setup()
    if not cfg.term_colors then return end
    vim.g.terminal_color_0 = light and c.fg or c.black
    vim.g.terminal_color_1 = c.red
    vim.g.terminal_color_2 = c.green
    vim.g.terminal_color_3 = c.yellow
    vim.g.terminal_color_4 = c.blue
    vim.g.terminal_color_5 = c.purple
    vim.g.terminal_color_6 = c.cyan
    vim.g.terminal_color_7 = light and c.light_grey_comment or c.fg
    vim.g.terminal_color_8 = c.grey
    vim.g.terminal_color_9 = c.red
    vim.g.terminal_color_10 = c.green
    vim.g.terminal_color_11 = c.yellow
    vim.g.terminal_color_12 = c.blue
    vim.g.terminal_color_13 = c.purple
    vim.g.terminal_color_14 = c.cyan
    vim.g.terminal_color_15 = light and c.light_grey_comment or c.fg
end

return M
