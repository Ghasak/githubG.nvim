for k in pairs(package.loaded) do
    --if k:match(".*onedark.*") then package.loaded[k] = nil end
    if k:match(".*onedark.*") then package.loaded[k] = nil end
end

-- require('onedark').setup()
-- require('onedark').colorscheme()

local onedark_status, onedark = pcall(require, "onedark")
if onedark_status then
	onedark.setup({})
	onedark.colorscheme()
end
