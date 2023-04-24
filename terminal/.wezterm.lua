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

-- Keybindings
config.keys = {
  -- Split pane
  {
    key = 'e',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal,
  },
  {
    key = 'o',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical,
  },

  -- New tab
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnTab('CurrentPaneDomain'),
  },

  -- Resize pane
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize({ 'Left', 2 }),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize({ 'Right', 2 }),
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize({ 'Up', 1 }),
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize({ 'Down', 1 }),
  },
}

return config
