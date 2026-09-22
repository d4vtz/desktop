hl.window_rule({
  match = { class = "pavucontrol" },
  float = true,
})

-- Permission rules require a Hyprland restart after changes.
hl.permission({ binary = "/usr/bin/grim", type = "screencopy", mode = "allow" })
