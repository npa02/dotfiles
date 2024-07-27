#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'

CONFIGS=(".moc" "autostart" "gtk-3.0" "neofetch" "nvim"
	"polybar" "pulseaudio-ctl" "ranger" "redshift" "rofi" "terminator"
	"vis" "zathura" "user-dirs.locale" "user-dirs.dirs" "glow"
)

if [ -d $HOME/.dotfiles/config ]; then
	CONFIG_PATH="${HOME}/.dotfiles/config"
	echo -e "${RED}path exists: $CONFIG_PATH${NC}"
elif [ -d $HOME/dotfiles/config ]; then
	CONFIG_PATH="${HOME}/dotfiles/config"
	echo -e "${RED}path exists: $CONFIG_PATH${NC}"
else
	echo -e "${RED}path doesn't exist: $HOME/.dotfiles/config${NC}"
	echo "please run: 'cd ~ && git clone https://github.com/duken72/dotfiles.git ~/.dotfiles'"
	exit
fi

function help() {
	echo "shell script for config management."
	echo
	echo "SYNOPSIS"
	echo "  cfg [OPTION]"
	echo
	echo "OPTIONS"
	echo "  -h, --help                  Display help"
	echo "  -i, --install               Install config"
	echo "  -u, --uninstall             Uninstall config"
	exit
}

function error() {
	echo -e "${RED}error: Invalid option${NC}"
	echo "check './cfg.sh --help' for valid ones."
	exit
}

function install() {
	echo "install config at HOME = $HOME/.config"
	for CONFIG in "${CONFIGS[@]}"; do
		ln -svf $CONFIG_PATH/$CONFIG -t ~/.config
	done
	cd $CONFIG_PATH/xfce4/xfconf/xfce-perchannel-xml
	for FILE in *; do
		ln -svf $CONFIG_PATH/xfce4/xfconf/xfce-perchannel-xml/$FILE -t ~/.config/xfce4/xfconf/xfce-perchannel-xml
	done
	# Others configs
	echo "install other configs"
	# Install console font
	sudo ln -svf $CONFIG_PATH/vconsole.conf -t /etc
	# Install windows config
	sudo ln -svf $CONFIG_PATH/TrueMinimalist -t /usr/share/themes
	# Install windows config
	mkdir -p ~/.local/share/icons
	# Install mouse config
	sudo ln -svf $CONFIG_PATH/Night_Diamond_Red -t ~/.local/share/icons
	# Install redshift config
	sudo ln -svf $CONFIG_PATH/redshift/*.svg -t /usr/share/icons/hicolor/scalable/apps
	# LightDM
	sudo cp ~/.dotfiles/Wallpapers/syn* /usr/share/pixmaps
	sudo cp ~/.dotfiles/config/LightDM/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
	sudo cp ~/.dotfiles/dfs/.face /var/lib/AccountsService/icons/duken72.png
	sudo cp ~/.dotfiles/config/LightDM/duken72 /var/lib/AccountsService/users/duken72
	# Install nbread to preview python notebook with ranger
	pipx install git+https://github.com/tnwei/nbread
	echo "config is installed. Enjoy :)"
	exit
}

function uninstall() {
	echo "uninstall config at $HOME/.config"
	for CONFIG in "${CONFIGS[@]}"; do
		if [ -L ~/.config/$CONFIG ]; then
			rm -v ~/.config/$CONFIG
		fi
	done
	echo "config are uninstalled .. but .. why?? :("
	exit
}

########################################################
# MAIN
########################################################
while [ "$1" != "" ]; do
	case $1 in
	-h | --help) help ;;
	-i | --install) install ;;
	-u | --uninstall) uninstall ;;
	*) error ;;
	esac
	shift
done

echo -e "${RED}cfg: missing operand${NC}"
echo "try './cfg.sh --help' for more information."
