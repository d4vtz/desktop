# d4vtz/desktop

Entorno Wayland reproducible para Arch Linux, construido desde cero alrededor de **Hyprland Lua + Quickshell**.

## Stack

Hyprland >= 0.55 (Lua), UWSM, Quickshell 0.3.x, Kitty, PipeWire/WirePlumber, NetworkManager, BlueZ, power-profiles-daemon, Hyprlock/Hypridle/Hyprpaper, Catppuccin Mocha, Papirus Dark y JetBrainsMono Nerd Font.

## Funciones

- 7 workspaces persistentes.
- Barra Quickshell con workspaces, reloj, volumen y batería.
- Launcher por IPC.
- Control Center con red, Bluetooth, audio, brillo y perfiles de energía.
- Servidor de notificaciones Quickshell.
- Historial de portapapeles con cliphist.
- Menú de sesión.
- Capturas con grim/slurp.
- Bloqueo e inactividad.
- Atajos multimedia.
- Configuración Hyprland modular en Lua.
- Entorno de sesión separado en UWSM.
- Backups automáticos durante instalación.

## Instalación

```bash
git clone https://github.com/d4vtz/desktop.git ~/Proyectos/desktop
cd ~/Proyectos/desktop
chmod +x install.sh
./install.sh
```

Inicia con:

```bash
uwsm start hyprland.desktop
```

## Atajos principales

| Atajo | Acción |
|---|---|
| Super+Enter | Kitty |
| Super+Space | Launcher |
| Super+C | Clipboard |
| Super+A | Control Center |
| Super+Q | Cerrar ventana |
| Super+F | Fullscreen |
| Super+V | Floating |
| Super+P | Pseudotile |
| Super+1…7 | Workspace |
| Super+Shift+1…7 | Mover ventana |
| Super+flechas | Cambiar foco |
| Super+Shift+flechas | Mover ventana |
| Super+Shift+L | Bloquear |
| Super+Shift+E | Sesión |
| Print | Captura de región |
| Shift+Print | Captura completa |

## Desarrollo

`.luarc.json` añade `/usr/share/hypr/stubs` a lua-language-server para completar la API `hl`.

La shell está separada del compositor: Hyprland controla ventanas, input y workspaces; Quickshell controla la experiencia de escritorio. Los procesos externos nunca se ejecutan de forma bloqueante dentro de callbacks Lua.
