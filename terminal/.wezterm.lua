local wezterm = require('wezterm')

-- Create a config and initialize it with the wezterm defaults
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Set the font
config.font = wezterm.font('Fira Code')

-- Maximize the window on startup
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
