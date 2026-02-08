-- Detect macOS appearance and set background before plugins load to avoid dark theme flash
local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
local result = handle:read("*a")
handle:close()
if result:match("Dark") then
  vim.o.background = "dark"
else
  vim.o.background = "light"
end

require("config.lazy")
