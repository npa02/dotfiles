#!/bin/bash

# LIBALPM hooks
echo "Setting up LIBALPM hooks..."
sudo ln -svf ~/.dotfiles/dfs/hook/*.hook -t /usr/share/libalpm/hooks
echo ""

# AURA - AUR helper
echo "Installing AURA..."
if ! type aura >/dev/null; then
	mkdir -p ~/WS && cd ~/WS && git clone https://aur.archlinux.org/aura-bin.git
	cd ~/WS/aura-bin && makepkg && ls | grep zst | sudo pacman -U - && rm -rf ~/WS/aura-bin
else
	echo "aura already installed."
fi
echo ""

# Install packages
# when install pkg group, use ^x to exclude x
echo "Installing pacman packages..."
sudo pacman -Syu
sudo pacman -S --needed zsh lightdm lightdm-gtk-greeter
for file in pkg_group pkg_pacman pkg_pacman_sub pkg_pacman_python; do
	sudo pacman -S --needed - <"/home/$USER/.dotfiles/pkg/$file.txt"
done
echo ""

echo "Installing AUR packages..."
sudo aura -Akax --needed aic94xx-firmware ast-firmware upd72020x-fw wd719x-firmware
sudo aura -Akax --needed brave-bin pulseaudio-ctl
sudo aura -Akax --needed moc-pulse
echo ""

echo "Removing orphans..."
pacman -Qtdq | sudo pacman -Rns -
echo ""

echo "Installation completed."
