#!/bin/sh

echo preload = $WALLPAPER > $HOME/.config/hypr/hyprpaper.conf 
echo wallpaper = eDP-1, $WALLPAPER >> $HOME/.config/hypr/hyprpaper.conf
echo wallpaper = eDP-2, $WALLPAPER >> $HOME/.config/hypr/hyprpaper.conf

wal -i $WALLPAPER --saturate 0.2

pywalfox update
