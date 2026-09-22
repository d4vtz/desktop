#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.local/state/desktop/backup-$(date +%Y%m%d-%H%M%S)"
[[ -f /etc/arch-release ]] || { echo "Este instalador requiere Arch Linux." >&2; exit 1; }
mkdir -p "$BACKUP" "$HOME/.config" "$HOME/.local/bin"
mapfile -t packages < <(grep -Ev '^\s*(#|$)' "$ROOT/packages.txt")
sudo pacman -Syu --needed --noconfirm "${packages[@]}"
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ "$(readlink -f "$dst" 2>/dev/null || true)" == "$(readlink -f "$src")" ]]; then return; fi
    mv "$dst" "$BACKUP/$(basename "$dst")"
  fi
  ln -s "$src" "$dst"
}
link "$ROOT/config/hypr" "$HOME/.config/hypr"
link "$ROOT/config/uwsm" "$HOME/.config/uwsm"
link "$ROOT/config/quickshell" "$HOME/.config/quickshell"
link "$ROOT/config/kitty" "$HOME/.config/kitty"
link "$ROOT/config/desktop" "$HOME/.config/desktop"
link "$ROOT/scripts/screenshot" "$HOME/.local/bin/screenshot"
for script in "$ROOT"/scripts/*; do chmod +x "$script"; link "$script" "$HOME/.local/bin/$(basename "$script")"; done
sudo systemctl enable --now NetworkManager.service bluetooth.service
sudo systemctl enable --now power-profiles-daemon.service || true
echo "Instalación base terminada. Backup: $BACKUP"
echo "Inicia con: uwsm start hyprland.desktop"
