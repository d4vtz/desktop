local mod = "SUPER"

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
hl.bind(mod .. " + Q", hl.dsp.window.kill())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))

hl.bind(mod .. " + LEFT", hl.dsp.focus.move("l"))
hl.bind(mod .. " + RIGHT", hl.dsp.focus.move("r"))
hl.bind(mod .. " + UP", hl.dsp.focus.move("u"))
hl.bind(mod .. " + DOWN", hl.dsp.focus.move("d"))

hl.bind(mod .. " + SHIFT + LEFT", hl.dsp.window.move("l"))
hl.bind(mod .. " + SHIFT + RIGHT", hl.dsp.window.move("r"))
hl.bind(mod .. " + SHIFT + UP", hl.dsp.window.move("u"))
hl.bind(mod .. " + SHIFT + DOWN", hl.dsp.window.move("d"))

for i = 1, 7 do
  hl.bind(mod .. " + " .. i, hl.dsp.workspace.change(tostring(i)))
  hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move_to_workspace(tostring(i)))
end

hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("qs ipc call session toggle"))
hl.bind("PRINT", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot area"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot screen"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
