#!/bin/bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/Windows-Everforest-Dark

echo "Updating the database..."
sleep 1
sudo apt update
clear

echo "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
sleep 1
sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions
clear

echo "Installing Themes and Icons..."
sleep 1
tar --extract --file $path/my-icons.tar.gz -C ~/ --strip-components=2
tar --extract --file $path/my-themes.tar.gz -C ~/ --strip-components=2
clear

echo "Installing the extensions..."
sleep 1
tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2
clear

echo "Applying The Custom DE Settings..."
sleep 1
dconf load / < $path/full-gnome-settings
clear

echo "Extracting Wallpapers in ~/Pictures and Applying Background..."
sleep 1
cp $path/Background/wallpaper.jpg ~/Pictures
gsettings set org.gnome.desktop.background picture-uri-dark file://$HOME/Pictures/wallpaper.jpg
clear

echo -n "Do you want to log out now to fully apply the theme? (Y/n): "
read -r r
if [[ "$r" == "Y" || "$r" == "y" || "$r" == "" ]]; then
    echo "Logging out in 3 seconds..."
    sleep 3
    gnome-session-quit --no-prompt
else
    echo "Please log out manually to apply the changes."
fi
