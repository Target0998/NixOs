#!/usr/bin/env bash
# Simple wallpaper switcher using swww
# Usage:
#   wallpaper.sh --random        pick a random image from ~/Pictures/wallpapers
#   wallpaper.sh --restore       restore last used wallpaper
#   wallpaper.sh /path/to/img    set a specific image

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_FILE="$HOME/.config/hypr/wallpaper_current"

set_wallpaper() {
    local img="$1"
    swww img "$img" \
        --transition-type grow \
        --transition-pos center \
        --transition-duration 0.8 \
        --transition-fps 60
    # Save for restore and hyprlock
    cp "$img" "$CACHE_FILE"
    echo "$img" > "$HOME/.config/hypr/wallpaper_last"
}

case "$1" in
    --restore)
        last=$(cat "$HOME/.config/hypr/wallpaper_last" 2>/dev/null)
        if [[ -f "$last" ]]; then
            swww img "$last" --transition-type none
            cp "$last" "$CACHE_FILE"
        fi
        ;;
    --random)
        img=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | shuf -n1)
        if [[ -z "$img" ]]; then
            echo "No wallpapers found in $WALLPAPER_DIR"
            exit 1
        fi
        set_wallpaper "$img"
        ;;
    "")
        # Interactive pick with rofi
        img=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null \
            | rofi -dmenu -p "wallpaper")
        [[ -n "$img" ]] && set_wallpaper "$img"
        ;;
    *)
        [[ -f "$1" ]] && set_wallpaper "$1" || echo "File not found: $1"
        ;;
esac
