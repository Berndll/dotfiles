#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

# 1. Get the currently active wallpaper to avoid repeats
# We use 'active' instead of 'listloaded' for better accuracy
CURRENT_WALL=$(hyprctl hyprpaper listactive | grep -oP '(?<= = ).*')

# 2. Pick a random file that isn't the current one
# Added -maxdepth 1 to avoid searching subfolders if not needed
WALLPAPER=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f ! -path "*$CURRENT_WALL*" | shuf -n 1)

if [ -n "$WALLPAPER" ]; then
    # 3. Preload the new wallpaper
    hyprctl hyprpaper preload "$WALLPAPER"
    
    # 4. Set the wallpaper for all monitors (using the empty selector ',')
    hyprctl hyprpaper wallpaper ",$WALLPAPER"
    
    # 5. Unload the previous wallpaper to save RAM
    hyprctl hyprpaper unload all
fi