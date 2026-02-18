local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Performance & rendering
config.front_end = "WebGpu"
config.animation_fps = 60
config.cursor_blink_rate = 500

-- Window appearance
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'CGA'
-- config.color_scheme = "cyberpunk"
config.window_background_opacity = 0.95
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

-- Font settings
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14

-- Disables font ligatures (ex. merging != or >= or =>)
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }

-- Scrollback & scrollbar
config.scrollback_lines = 10000
config.enable_scroll_bar = true

-- Behavior
config.adjust_window_size_when_changing_font_size = false

-- Bypass tmux mouse reporting when CMD is held, allowing CMD+click to open URLs
config.bypass_mouse_reporting_modifiers = "CMD"

-- For example, we want Command+C to trigger standard Ctrl+C
-- in order to be able to paste in a standard MacOS way
-- but in order to do that, we need to send the key for Ctrl+C
-- as NVIM and TMUX and others do not support Command
local command_keys = { "c", "p", "g", "u", "l", "Enter" }

-- @TODO: send those strings only when in NVIM selected pane
config.keys = {
	{
		key = "s",
		mods = "CMD",
		action = wezterm.action.SendString(":w\n"),
	},
	{
		key = "a",
		mods = "CMD",
		action = wezterm.action.SendString("\x1bggVG"),
	},
	{
		key = "v",
		mods = "CMD",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- in order to be able to create a new line with Shift + Enter in Claude Code
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendKey({ key = "Enter", mods = "ALT" }),
	},
}

for _, k in ipairs(command_keys) do
	table.insert(config.keys, {
		key = k,
		mods = "CMD",
		action = wezterm.action.SendKey({ key = k, mods = "CTRL" }),
	})
end

return config
