-- WCAG contrast check for the glight palette.
-- usage: [PALETTE=/path/palette.lua] nvim --clean --headless --cmd "set rtp^=<plugin>" -c "luafile check.lua"
-- PALETTE overrides lua/onedark/palette.lua (used to run against the OLD palette from git HEAD).
-- Prints FAIL lines and "RESULT fails=<n>". Exit code 1 when any required check fails.
local P = os.getenv("PALETTE")
if P and P ~= "" then package.loaded["onedark.palette"] = dofile(P) end
vim.o.background = "dark" -- until T2 lands, background=light forces style "light"

local rec, order = {}, {}
local orig = vim.api.nvim_command
vim.api.nvim_command = function(cmd)
  local g, fg, bg, fmt = cmd:match("^highlight (%S+) guifg=(%S+) guibg=(%S+) guisp=%S+ gui=(%S+)$")
  if g then
    if not rec[g] then order[#order + 1] = g end
    rec[g] = { fg = fg, bg = bg, fmt = fmt }
  end
  return orig(cmd)
end
require("onedark").setup({ style = "glight" })
require("onedark").colorscheme()
vim.api.nvim_command = orig
local c = require("onedark.colors")
local pal = require("onedark.palette")
local out, fails = {}, 0
local function say(s) out[#out + 1] = s end

-- key set must equal gdark's, every value a #rrggbb
for k in pairs(pal.gdark) do if pal.glight[k] == nil then fails = fails + 1; say("FAIL missing key " .. k) end end
for k, v in pairs(pal.glight) do
  if pal.gdark[k] == nil then fails = fails + 1; say("FAIL extra key " .. k) end
  if not tostring(v):match("^#%x%x%x%x%x%x$") then fails = fails + 1; say("FAIL bad hex " .. k .. "=" .. tostring(v)) end
end

local function lum(hex)
  local function ch(i)
    local v = tonumber(hex:sub(i, i + 1), 16) / 255
    return v <= 0.04045 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * ch(2) + 0.7152 * ch(4) + 0.0722 * ch(6)
end
local function ratio(a, b)
  local x, y = lum(a), lum(b)
  if x < y then x, y = y, x end
  return (x + 0.05) / (y + 0.05)
end
local keys_of = {}
for k, v in pairs(pal.glight) do
  local h = v:lower(); keys_of[h] = keys_of[h] or {}; table.insert(keys_of[h], k)
end
local function kn(h) local t = keys_of[h:lower()] or {}; table.sort(t); return table.concat(t, "|") end
local function check(name, fg, bg, thr)
  local r = ratio(fg, bg)
  if r < thr then
    fails = fails + 1
    say(string.format("FAIL %5.2f<%.1f %-34s fg=%s(%s) bg=%s(%s)", r, thr, name, fg, kn(fg), bg, kn(bg)))
  end
  return r
end
local UI = { "Border", "Separator", "VertSplit", "Indent", "NonText", "Whitespace", "SpecialKey", "Thumb", "Bullet", "Marker" }
local function thr_of(g)
  for _, p in ipairs(UI) do if g:find(p) then return 3.0 end end
  return 4.5
end

-- bg-only blocks with no glyph on them: UI check of the block against the canvas
local BLOCK = { PmenuThumb = true, MiniTrailspace = true }
-- groups that fail the floor on purpose: either no palette value can fix them (highlights.lua pairs
-- two keys whose other roles force them the same way — both dark, or a bg key used as fg), or the
-- value is a deliberate choice for a decoration (the SnacksIndent entries below). Printed as KNOWN,
-- not counted, listed in the report.
local KNOWN = {
  MatchParen = "highlights.lua:76 bg=c.grey under syntax fg; grey is LineNr/NonText fg (:58,:77) so must be dark",
  TermCursor = "highlights.lua:48 fg=blue bg=fg + reverse: two text colours on top of each other",
  BufferCurrentMod = "highlights.lua:395 fg=c.black (editor bg) on editor bg; identical in gdark",
  IndentBlanklineChar = "highlights.lua:591 fg=c.bg1 (a bg layer); legacy ibl v2 group",
  IndentBlanklineContext = "highlights.lua:592 fg=orange bg=grey, both text colours; legacy ibl v2",
  SnacksIndent = "deliberate glight choice: highlights.lua:769 holds the indent guides at bg3, 1.45:1 on white — a decoration, the 3.0 UI floor is not moved",
  SnacksIndentScope = "deliberate glight choice: palette.lua:49 holds the cursor-block bar one step darker at 2.01:1 on white, the 3.0 UI floor is not moved",
}
for i = 1, 6 do KNOWN["IndentBlanklineIndent" .. i] = "highlights.lua:585-590 fg=blue bg=fg, both text colours; legacy ibl v2" end
local known = 0
local N = rec.Normal
local checked = 0
local syntax_fgs = {}
for _, g in ipairs(order) do
  local h = rec[g]
  if g:sub(1, 1) == "@" and h.fg ~= "none" and h.bg == "none" then syntax_fgs[h.fg] = g end
end
local overlays = {}
for _, g in ipairs(order) do
  local h = rec[g]
  local fg, bg = h.fg, h.bg
  if fg == "none" and bg == "none" then goto continue end
  if fg ~= "none" and fg == bg then say("HIDDEN " .. g .. " fg=bg=" .. fg .. "(" .. kn(fg) .. ")"); goto continue end
  if bg == "none" then bg = g:match("^NeoTree") and c.bg_d or N.bg end
  if BLOCK[g] then checked = checked + 1; check(g .. "(block vs canvas)", bg, N.bg, 3.0); goto continue end
  if fg == "none" then fg = N.fg; overlays[#overlays + 1] = { g, bg } end
  if h.fmt:find("reverse") then fg, bg = bg, fg end
  if KNOWN[g] then
    known = known + 1
    say(string.format("KNOWN %5.2f %-28s fg=%s bg=%s  %s", ratio(fg, bg), g, fg, bg, KNOWN[g]))
    goto continue
  end
  checked = checked + 1
  local r = check(g, fg, bg, thr_of(g))
  if (os.getenv("SHOW") or ""):find("," .. g .. ",", 1, true) then
    say(string.format("SHOW %5.2f %-20s fg=%s(%s) bg=%s(%s)", r, g, fg, kn(fg), bg, kn(bg)))
  end
  ::continue::
end

-- lualine theme (bg none -> c.black, the statusline c-section default)
local lt = require("lualine.themes.onedark")
for mode, secs in pairs(lt) do
  for s, v in pairs(secs) do
    checked = checked + 1
    check("lualine." .. mode .. "." .. s, v.fg, (v.bg == "none" or not v.bg) and c.black or v.bg, 4.5)
  end
end
-- barbecue (drawn on WinBar, bg = c.black)
for k, v in pairs(require("barbecue.theme.onedark")) do
  if v.fg then checked = checked + 1; check("barbecue." .. k, v.fg, c.black, 4.5) end
end
-- terminal ANSI colours as text on the editor bg (0 = c.black by terminal.lua:7, structural)
for i = 1, 15 do
  local v = vim.g["terminal_color_" .. i]
  checked = checked + 1
  check("terminal_color_" .. i, v, c.black, i == 8 and 3.0 or 4.5)
end

-- layering: bg0..bg3/bg_d must not all be equal and must step canvas -> border
local layers = { c.bg0, c.bg1, c.bg2, c.bg3 }
for i = 2, 4 do
  if not (lum(layers[i]) < lum(layers[i - 1])) then fails = fails + 1; say("FAIL bg" .. (i - 1) .. " not darker than bg" .. (i - 2)) end
end
if c.bg_d:lower() == c.black:lower() then fails = fails + 1; say("FAIL bg_d == black (sidebar invisible)") end

-- informational: worst syntax colour on each bg-only overlay
for _, o in ipairs(overlays) do
  local worst, wg = 99, ""
  for fg, sg in pairs(syntax_fgs) do local r = ratio(fg, o[2]); if r < worst then worst, wg = r, sg end end
  say(string.format("INFO overlay %-24s bg=%s(%s) normal-fg %.2f, worst syntax %.2f (%s)", o[1], o[2], kn(o[2]), ratio(N.fg, o[2]), worst, wg))
end
say(string.format("RESULT style=%s groups=%d checked=%d known=%d fails=%d", vim.g.onedark_config.style, #order, checked, known, fails))
io.stdout:write(table.concat(out, "\n") .. "\n")
vim.cmd(fails > 0 and "cquit 1" or "qa!")
