-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Neutron'

-- config.font = wezterm.font("MesloNG Nerd Font")
-- config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font = wezterm.font("MonaspiceNe Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})

--local session_manager = require("wezterm-session-manager/session-manager")

--wezterm.on("save_session", function(window) session_manager.save_state(window) end)
--wezterm.on("load_session", function(window) session_manager.load_state(window) end)
--wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

wezterm.on("gui-startup", resurrect.resurrect_on_gui_startup)

config.enable_scroll_bar = false
-- config.use_fancy_tab_bar = false

-- Set the maximum width of tabs
-- config.tab_max_width = 400 -- adjust this value as needed

-- Optional: Position the tab bar at the bottom
config.tab_bar_at_bottom = true

-- Optional: Hide the tab bar when there's only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Define custom key bindings
config.keys = {
    -- Split horizontally: Ctrl + ]
    {
      key = ']',
      mods = 'CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- Split vertically: Ctrl + \
    {
      key = '\\',
      mods = 'CTRL',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Close pane: w (without any modifier)
    {
      key = 'w',
      mods = 'CTRL',
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
    {
      key = "w",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
          resurrect.save_state(resurrect.workspace_state.get_workspace_state())
        end),
    },
    {
      key = "W",
      mods = "ALT",
      action = resurrect.window_state.save_window_action(),
    },
    {
      key = "T",
      mods = "ALT",
      action = resurrect.tab_state.save_tab_action(),
    },
    {
      key = "s",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
          resurrect.save_state(resurrect.workspace_state.get_workspace_state())
          resurrect.window_state.save_window_action()
        end),
    },
    {
      key = "r",
      mods = "ALT",
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, "^([^/]+)") -- match before '/'
          id = string.match(id, "([^/]+)$") -- match after '/'
          id = string.match(id, "(.+)%..+$") -- remove file extention
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == "workspace" then
            local state = resurrect.load_state(id, "workspace")
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == "window" then
            local state = resurrect.load_state(id, "window")
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == "tab" then
            local state = resurrect.load_state(id, "tab")
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
    },
    
--    {
--        key = "S",
--       mods = "LEADER",
--        action = wezterm.action{EmitEvent = "save_session"}
--    },
--    {
--        key = "L",
--        mods = "LEADER",
--        action = wezterm.action{EmitEvent = "load_session"}
--    },
--    {
--       key = "R",
--        mods = "LEADER",
--        action = wezterm.action{EmitEvent = "restore_session"}
--    },
  }

-- and finally, return the configuration to wezterm
return config
