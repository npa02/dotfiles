#!/bin/bash
PKG_DIR=/home/npa02/.dotfiles/pkg

# Clear existing content in certain files (for later concatenation)
>${PKG_DIR}/pkg_pacman.old

# Backup packages
pacman -Qem | grep -v debug >${PKG_DIR}/pkg_aura.old
pacman -Qtn | grep -v python- | grep -v texlive >>${PKG_DIR}/pkg_pacman.old
# Filter packages that are installed via pkg groups
while read pkg; do
	sed -i "/$pkg/d" ${PKG_DIR}/pkg_pacman.old
done <${PKG_DIR}/pkg_group.txt
