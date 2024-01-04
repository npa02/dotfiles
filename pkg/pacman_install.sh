#!/bin/bash

sudo pacman -Syu
sudo pacman -S --needed xorg xorg-xinit picom xdg-user-dirs \
    lightdm lightdm-gtk-greeter \
    xfce4 xfce4-screensaver xfce4-screenshooter xfce4-notifyd xfce4-whiskermenu-plugin \
    zsh fd htop terminator fzf man-pages neofetch \
    rofi polybar sxhkd udisks2 ntfs-3g zip unzip \
    pulseaudio pavucontrol alsa-utils \
    ranger ueberzug ffmpegthumbnailer docx2txt ffmpeg \
    zathura zathura-pdf-mupdf \
    npm neovim accountsservice

awk '{print $1}' ~/dotfiles/pkg/pkg_pacman.txt > /tmp/t.txt
sudo pacman -S --needed - < /tmp/t.txt # when install pkg group, use ^x to exclude x
rm -f /tmp/t.txt

# AURA - AUR helper
cd && mkdir -p WS && cd WS
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin && makepkg
ls | grep zst | sudo pacman -U -
sudo aura -Akax brave-bin cli-visualizer pulseaudio-ctl siji-git \
    tty-clock-git xfce4-panel-profiles #tllocalmgr-git

sudo cp ~/dotfiles/dfs/hook/*.hook /usr/share/libalpm/hooks
