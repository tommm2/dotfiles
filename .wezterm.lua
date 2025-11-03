-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- dynamic padding
wezterm.on("update-status", function(window, _)
	local tab = window:active_tab()
	local panes = tab:panes()
	local alt_screen_active = false

	for i = 1, #panes, 1 do
		local pane = panes[i]
		if pane:is_alt_screen_active() then
			alt_screen_active = true
			break
		end
	end

	if alt_screen_active then
		window:set_config_overrides({
			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
		})
	else
		window:set_config_overrides({
			window_padding = { left = 8, right = 8, top = 0, bottom = 0 },
		})
	end
end)

config.font = wezterm.font("Maple Mono NF", { weight = "Medium" })
config.font_size = 16
config.initial_cols = 150
config.initial_rows = 50
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80

config.keys = {
	{ key = "h", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Next") },
	{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Prev") },
	{ key = "x", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}
config.color_scheme = "Catppuccin Mocha"

return config
