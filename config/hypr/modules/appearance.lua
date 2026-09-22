hl.config({
  general = {
    ["col.active_border"] = "0xff89b4fa",
    ["col.inactive_border"] = "0xff45475a",
  },
  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.96,
    shadow = { enabled = true, range = 14, render_power = 3, color = "0xdd11111b" },
    blur = { enabled = true, size = 8, passes = 2, vibrancy = 0.15 },
  },
  dwindle = { preserve_split = true, smart_split = true },
})
