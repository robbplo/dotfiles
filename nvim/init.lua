require 'packer_init'

-- require everything from ~/.config/nvim/lua
local base_path = vim.fn.stdpath('config') .. '/lua'
local scan = require 'plenary.scandir'
local files = scan.scan_dir(base_path, { depth = 5, add_dirs = false })

for _, file in ipairs(files) do
  local module = file:match('/lua/(.*)%.lua')
  if module then
    local module_path = module:gsub('/', '.')
    require(module_path)
  end
end
