#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.xyz
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: voidLinux.sh
#       USAGE: ./voidLinux.sh
#
# DESCRIPTION: install software and window manager
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 11-07-20 19:04
#
# -----------------------------------------------------------------

update_voidlinux() {
	echo ""
	echo " Updating Void Linux"
	echo ""
	sleep 2;

	sudo xbps-install -Syu &&
	echo ""
	echo " Void Linux Updated"
	echo ""
}

install() {
	echo ""
	echo " ##### xorg display server #####"
	echo ""
	sleep 2

	PKGS=(xorg
	xorg-fonts
	lightdm
	lightdm-mini-greeter)

	sudo xbps-install -Sy "${PKGS[@]}" &&
	echo " xorg and lightdm successfully installed"

	sudo cp -af config-files/configs/lightdm-mini-greeter.conf /etc/lightdm/ &&
	echo " New mini greeter has been copied" || echo " Upss!!!!"
	sleep 5

	clear
	echo ""
	echo " ##### INSTALLING CLI AND OTHER SOFTWARE #####"
	echo ""
	sleep 2

	PKGS=(wget
	curl
	scrot
	xautolock
	i3lock
	ImageMagick
	alsa-utils
	lm_sensors
	arandr
	xarchiver
	udevil
	tlp
	libX11-devel
	libXft-devel
	pkg-config
	gcc
	make
	libXinerama-devel
	libxfce4ui-devel
	polkit
	polkit-gnome
	intltool
	libnotify-devel
	upower-devel
	gtk-engine-murrine
	dunst
	libnotify
	Adapta
	papirus-icon-theme
	rxvt-unicode
	harfbuzz-devel
	vim-huge
	amfora
	ranger
	calcurse
	htop
	neofetch
	mpv
	w3m
	w3m-img)

	sudo xbps-install -Sy "${PKGS[@]}" &&
	echo " Applications Successfully installed" || echo " Upssss!!!!"
	echo ""

	echo " Setting up Rangen File Manager"
	echo ""
	sleep 2

	ranger --copy-config=all

	sed -i 's/set preview_images false/set preview_images true/g' $HOME/.config/ranger/rc.conf &&
	echo " Preview images activated" || echo " Upsss!!!"
	echo ""

	sed -i 's/set draw_borders none/set draw_borders both/g' $HOME/.config/ranger/rc.conf &&
	echo " Draw borders activated" || echo  " Not Againg!!!"
	sleep 5

	clear
	echo ""
	echo " ##### GUI APPLICATIONS #####"
	echo ""
	sleep 2

	PKGS=(lxappearance
	mousepad
	xfce4-power-manager
	xfce4-appfinder
	pcmanfm
	epdfview
	sxiv
	gimp
	sigil
	calibre
	libreoffice
	nitrogen)

	sudo xbps-install -Sy "${PKGS[@]}" &&
	echo " GUI Applications Successfully installed" || echo " Something is not right!!!"
	echo ""

	while true; do
		read -p " Install Surf web browser [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo xbps-install -S surf ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	while true; do
		read -p " Install Chromium [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo xbps-install -S chromium &&
				echo " Chromium has been installed" || echo " We have a problem in the Matrix!!!" ; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " Install Firefox [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo xbps-install -S firefox &&
				echo " Firefox has been installed" || echo " Not Again!!!!" ; break ;;
			[Nn]* )
				break ;;
			* )
				echo " Please answer yes or no." ;;
		esac
	done
	sleep 5

	clear
	echo " ##### INSTALLING SUCKLESS SOFTWARE #####"
	echo ""
	sleep 2

	cd config-files/systems/dwm/
	sudo make clean install
	cd ../../..

	echo ""
	echo ""
	echo " ### Installing dmenu ###"
	echo ""
	sleep 2

	cd config-files/systems/dmenu
	sudo make clean install
	cd ../../..

	echo ""
	echo ""
	echo " ### Installing slstatus, status bar for dwm ###"
	echo ""
	sleep 2

	cd config-files/systems/slstatus
	sudo make clean install
	cd ../../..
	sleep 2

	echo ""
	echo ""
	echo " ### Installing simple terminal st ###"
	echo " ### This is the built from Luke Smith ###"
	echo ""
	sleep 2

	cd config-files/systems/st
	sudo make clean install
	cd ../../..
	sleep 2

	echo ""
	echo ""

	## xsessions directory
	### Check for dir, if not found create it using the mkdir ###
	xsessions="/usr/share/xsessions"
	[ ! -d "$xsessions" ] && sudo mkdir -p "$xsessions" &&
	echo " xsessions directory was created" || echo " $xsessions already exist!"
	echo ""

	sudo cp config-files/configs/dwm.desktop /usr/share/xsessions/dwm.desktop &&
	echo " dwm.desktop entry has been copied" || echo " I dunno what happend!!"
	echo ""

	## DWM directory
	### Check for dir, if not found create it using the mkdir ###
	dldir2="$HOME/.dwm"
	[ ! -d "$dldir2" ] && mkdir -p "$dldir2" &&
	echo " dwm directory was created" || echo " dwm directory already exist"
	echo ""

	cp -af config-files/configs/autostart.sh $HOME/.dwm/ &&
	echo " autostart has been copied" || echo " Holly Shhhhhh!!!"
	echo ""

	cp -af config-files/configs/sysact.sh $HOME/.dwm/ &&
	echo " system account files has been copied" || echo " We have a problem again!!!"
	echo ""

	cp -af config-files/configs/dmenu-programs.sh $HOME/.dwm/ &&
	echo " dmenu custom file has been copied" || echo " Not again!!!"
	echo ""

	cp -af config-files/configs/autostart_blocking.sh $HOME/.dwm/ &&
	echo " system autostart_blocking files has been copied" || echo " We have a problem again!!!"
	echo ""

	cp -af config-files/configs/Xresources $HOME/.Xresources &&
	echo " New Xresources file has been copied" || echo " Againnnn!!!"
	echo ""

	cp -af config-files/configs/bash_profile $HOME/.bash_profile &&
	echo " New Bash Profile file has been copied" || echo " Againnnn!!!"
	echo ""

	cp -af config-files/configs/bashrc $HOME/.bashrc &&
	echo " New bashrc file has been copied" || echo " Againnnn!!!"
	echo ""
	sleep 5

	clear
	echo " ##### NEW DIRECTORIES AND CONFIG FILES ####"
	echo ""
	sleep 2

	echo " Cloning and installing Dracula gtk theme"
	git clone https://github.com/dracula/gtk.git &&
	sudo mv gtk /usr/share/themes/Dracula &&
	sudo chmod +x -R /usr/share/themes/Dracula &&
	echo " Dracula gtk theme has been installed" || echo " No way!!!!"
	echo ""

	sudo cp -af config-files/configs/blurlock /usr/bin/ &&
	sudo chmod +x /usr/bin/blurlock &&
	echo " blurlock has been installed" || echo " Sorry!!!"
	echo ""

	sudo cp -af config-files/configs/dc-scrot /usr/bin/ &&
	sudo chmod +x /usr/bin/dc-scrot &&
	echo " Scrot config files have been installed" || echo " Again!!!"
	echo ""

	## dunst directory
	### Check for dir, if not found create it using the mkdir ###
	dundir="$HOME/.config/dunst"
	[ ! -d "$dundir" ] && mkdir -p "$dundir" &&
	echo " dunst directory was created" || echo " $dundir already exist!"
	echo ""

	cp -af config-files/configs/dunstrc $HOME/.config/dunst/ &&
	echo " dunstrc file was copied" || echo " SSSSShhhh!!!!"
	echo ""

	## Desktop directory
	### Check for dir, if not found create it using the mkdir ###
	desktopdir="$HOME/Desktop"
	[ ! -d "$desktopdir" ] && mkdir -p "$desktopdir" &&
	echo " Desktop directory was created" || echo " $desktopdir already exist!"
	echo ""

	## Documents directory
	### Check for dir, if not found create it using the mkdir ###
	docdir="$HOME/Documents"
	[ ! -d "$docdir" ] && mkdir -p "$docdir" &&
	echo " Documents directory was created" || echo " $docdir already exist!"
	echo ""

	## Downloads directory
	### Check for dir, if not found create it using the mkdir ###
	dowdir="$HOME/Downloads"
	[ ! -d "$dowdir" ] && mkdir -p "$dowdir" &&
	echo " Downloads directory was created" || echo " $dowdir already exist!"
	echo ""

	## Music directory
	### Check for dir, if not found create it using the mkdir ###
	musdir="$HOME/Music"
	[ ! -d "$musdir" ] && mkdir -p "$musdir" &&
	echo " Music directory was created" || echo " $musdir already exist!"
	echo ""

	## Pictures directory
	### Check for dir, if not found create it using the mkdir ###
	picdir="$HOME/Pictures"
	[ ! -d "$picdir" ] && mkdir -p "$picdir" &&
	echo " Pictures directory was created" || echo " $picdir already exist!"
	echo ""

	## Videos directory
	### Check for dir, if not found create it using the mkdir ###
	vidir="$HOME/Videos"
	[ ! -d "$vidir" ] && mkdir -p "$vidir" &&
	echo " Videos directory was created" || echo " $vidir already exist!"
	echo ""

	## Templates directory
	### Check for dir, if not found create it using the mkdir ###
	temdir="$HOME/Templates"
	[ ! -d "$temdir" ] && mkdir -p "$temdir" &&
	echo " Videos directory was created" || echo " $temdir already exist!"
	echo ""

	## xsessions directory (not present in void linux)
	### Check for dir, if not found create it using the mkdir ###
	xsessions="/usr/share/xsessions"
	[ ! -d "$xsessions" ] && sudo mkdir -p "$xsessions" &&
	echo " xsessions directory was created" || echo " xsessions directory already exist"
	echo ""
	sleep 5

	clear
	echo ""
	echo " ##### LIGHTDM AND LIGHTDM-MINI-GREETER CONFIGURATION #####"
	echo ""
	sleep 2

	read -p " Which is your user name : " choice;
	sudo sed -i 's/user = CHANGE_ME/user = '$choice'/g' /etc/lightdm/lightdm-mini-greeter.conf &&
	echo " User added to lightdm-mini-greeter" || echo " No way!!!!"
	echo ""

	sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-mini-greeter/g' /etc/lightdm/lightdm.conf &&
	sudo sed -i 's/#user-session=default/user-session=dwm/g' /etc/lightdm/lightdm.conf &&
	echo " Lightdm setup is done!!" || echo " Something is happening!!!"

	sudo ln -s /etc/sv/dbus /var/service/dbus
	sudo ln -s /etc/sv/lightdm /var/service/lightdm

	sleep 2

	while true; do
		read -p " Would you like to restart you system now [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo reboot ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
	echo ""
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
	echo " __      __   _     _ _      _                   "
	echo " \ \    / /  (_)   | | |    (_)                  "
	echo "  \ \  / /__  _  __| | |     _ _ __  _   ___  __ "
	echo "   \ \/ / _ \| |/ _' | |    | | '_ \| | | \ \/ / "
	echo "    \  / (_) | | (_| | |____| | | | | |_| |>  <  "
	echo "     \/ \___/|_|\__,_|______|_|_| |_|\__,_/_/\_\ "
	echo ""
	echo " A build start for Void Linux with only the necessay"
	echo ""
	echo " 1 - Update Void Linux"
	echo " 2 - Install"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; update_voidlinux ; press_enter ;;
		2) clear; install ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
