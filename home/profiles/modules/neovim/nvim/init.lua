-- pulls package locations from the nix store instead of from Lazy
local nixos_plugins_file = vim.env.XDG_CONFIG_HOME .. '/nvim.nix/init.lua'

-- Ensure the file exists
if vim.fn.filereadable(nixos_plugins_file) == 1 then
  -- Source the file to get the plugin paths
  dofile(nixos_plugins_file)
else
  print('Nixos plugins file not found')
end

require("config.options")
require("config.keymaps")

require("config.lazy")
