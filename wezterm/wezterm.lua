local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- for example, we want Command+C to trigger standard Ctrl+C
-- in order to be able to paste in a standard MacOS way
-- but in order to do that, we need to send the key for Ctrl+C
-- as NVIM and TMUX and others do not support Command
local command_keys = { "c", "p", "u" }

config.keys = {
	{
		key = "s",
		mods = "CMD",
		action = wezterm.action.SendString(":w\n"),
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
