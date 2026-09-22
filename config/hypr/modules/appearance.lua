hl.config({
  general = {
    ["col.active_border"] = "rgba(89b4faff) rgba(cba6f7ff) 45deg",
    ["col.inactive_border"] = "rgba(45475aaa)",
  },
  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.96,
    shadow = {
      enabled = true,
      range = 14,
      render_power = 3,
      color = "rgba(11111bdd)",
    },
    blur = {
      enabled = true,
      size = 8,
      passes = 2,
      vibrancy = 0.15,
    },
  },
  dwindle = {
    pseudotile = true,
    preserve_split = true,
    smart_split = true,
  },
})
