local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true

-- Disables font ligatures (ex. merging != or >= or =>)
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }

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
}

for _, k in ipairs(command_keys) do
	table.insert(config.keys, {
		key = k,
		mods = "CMD",
		action = wezterm.action.SendKey({ key = k, mods = "CTRL" }),
	})
end

return config
