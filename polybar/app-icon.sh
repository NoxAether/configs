#!/usr/bin/env sh

# Get active window class
active_window_id=$(xdotool getactivewindow)
class=$(xprop -id $active_window_id WM_CLASS | awk -F '"' '{print $4}' 2>/dev/null)

# Map class to icon
case "$class" in
    Firefox|Brave-browser|brave-browser|Firefox|firefox|Navigator) icon="" ;;
    Doom|doom|Emacs|emacs|kitty|*terminal*) icon="" ;;
    Thunar|nautilus|dolphin|pcmanfm) icon="" ;;
    Spotify|spotify) icon="" ;;
    VLC|vlc) icon="" ;;
    Discord|discord) icon="" ;;
    *) icon="" ;; # Default icon
esac

echo "$icon"
