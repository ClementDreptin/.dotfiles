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
}

-- Generate keybindings that use the arrow keys
local directions = { 'Left', 'Right', 'Up', 'Down' }
for _, direction in pairs(directions) do
  local keyname = direction .. 'Arrow'

  -- Resize pane
  table.insert(config.keys, {
    key = keyname,
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize({ direction, 1 }),
  })

  -- Switch pane
  table.insert(config.keys, {
    key = keyname,
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection(direction),
  })
end

return config
