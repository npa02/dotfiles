#!/bin/bash

clear
if [ -f pkg_aura.old ] && [ -f pkg_aura.new ]; then
	delta pkg_aura.old pkg_aura.new
fi
if [ -f pkg_pacman.old ] && [ -f pkg_pacman.new ]; then
	delta pkg_pacman.old pkg_pacman.new
fi
