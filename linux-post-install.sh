#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: linux-post-install.sh
#       USAGE: ./linux-post-install.sh
#
# DESCRIPTION: install all necesary to run a full system
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 08-22-20 9:15
#
# -----------------------------------------------------------------

arch() {
	config-files/archLinux.sh
}

debian() {
	config-files/debian.sh
}

void() {
	config-files/voidLinux.sh
}

press_enter() {
	echo ""
	echo -n " Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo " Incorrect selection! try again"
}

until [ "$selection" = "0" ]; do
	clear
	echo ""
	echo " DarknessCode"
	echo "  _ _                   _____            "
	echo " | (_)                 / ____|           "
	echo " | |_ _ __  _   ___  _| (___  _   _ ___  "
	echo " | | | '_ \| | | \ \/ /\___ \| | | / __| "
	echo " | | | | | | |_| |>  < ____) | |_| \__ \ "
	echo " |_|_|_| |_|\__,_/_/\_\_____/ \__, |___/ "
	echo "                               __/ |     "
	echo "                              |___/      "
	echo ""
	echo " Install all necesary software for:"
	echo ""
	echo " 1 - Arch Linux"
	echo " 2 - Debian"
	echo " 3 - Void Linux"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; arch   ;;
		2) clear; debian ;;
		3) clear; void   ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
