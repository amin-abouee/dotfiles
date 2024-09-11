local wezterm = require 'wezterm'

local config = {}

-- Set the color scheme to Neon
-- config.color_scheme = "Neutron"
config.color_scheme = "Neon (terminal.sexy)"

config.font_size = 13.0

config.font = wezterm.font("MonaspiceNe Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})

--config.tab_max_width = 30

config.enable_scroll_bar = false

-- Change the tab bar position
config.tab_bar_at_bottom = true

-- Define custom key bindings
config.keys = {
  -- Split horizontally: CMD + ]
  {
    key = ']',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split vertically: CMD + \
  {
    key = '\\',
    mods = 'CMD',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Close pane: CMD + w
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- Switch to pane on the left: Alt + Left Arrow
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  -- Switch to pane on the right: Alt + Right Arrow
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  -- Switch to pane above: Alt + Up Arrow
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  -- Switch to pane below: Alt + Down Arrow
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
}

-- You can add more configuration options here as needed
-- For example:
-- config.font = wezterm.font("JetBrains Mono")
-- config.font_size = 11.0

return config
