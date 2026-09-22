# d4vtz/desktop

Entorno de escritorio Wayland reproducible para Arch Linux.

## Arquitectura

- **Hyprland >= 0.55** configurado nativamente en **Lua**.
- **Quickshell** como shell de escritorio.
- **UWSM** para gestionar la sesión y el entorno.
- **PipeWire/WirePlumber**, NetworkManager, BlueZ y power-profiles-daemon.
- Catppuccin Mocha, Papirus Dark, Noto Sans y JetBrainsMono Nerd Font.

Hyprland se divide en módulos Lua independientes bajo `config/hypr/modules/`. El punto de entrada es `config/hypr/hyprland.lua`.

Las variables de entorno de sesión viven en `config/uwsm/env`, no en Hyprland, para respetar el modelo de UWSM.

## Instalación

```bash
git clone https://github.com/d4vtz/desktop.git ~/Proyectos/desktop
cd ~/Proyectos/desktop
chmod +x install.sh
./install.sh
```

Después inicia la sesión con:

```bash
uwsm start hyprland.desktop
```

## Desarrollo Lua

El repositorio incluye `.luarc.json` apuntando a `/usr/share/hypr/stubs`, por lo que lua-language-server puede conocer la API `hl` de Hyprland.

## Estado

La base de Hyprland/UWSM ya está estructurada. La siguiente capa del proyecto es la shell Quickshell modular: barra, launcher, control center, notificaciones, clipboard y menú de sesión.
