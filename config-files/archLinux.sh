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
#        FILE: archLinux.sh
#       USAGE: ./archLinux.sh
#
# DESCRIPTION: install utilities and software in arch based systems
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 07-08-20 10:49
#
# -----------------------------------------------------------------

update() {
	echo ""
	echo " Updating Arch Linux"
	echo ""
	sleep 2

	sudo pacman -Syu &&
	echo ""
	echo " Arch Linux Updated"
	echo ""
}

install() {
	echo ""
	echo " Installing x windows system and display manager"
	echo ""
	sleep 2

	PKGS=(xorg-server
	xorg-apps
	xorg-fonts-misc
	lightdm)

	sudo pacman -S --noconfirm --needed "${PKGS[@]}" &&
	echo " xorg and lightdm successfully installed"
	echo ""

	#lightdm-slick-greeter
	git clone https://aur.archlinux.org/lightdm-slick-greeter.git
	cd lightdm-slick-greeter
	makepkg -sri
	cd ..
	sudo rm -r lightdm-slick-greeter
	echo ""

	sudo cp -af config-files/configs/slick-greeter.conf /etc/lightdm/ &&
	echo " New slick greeter has been copied" || echo " Upss!!!!"
	echo ""
	sleep 2

	sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/g' /etc/lightdm/lightdm.conf &&
	sudo sed -i 's/#user-session=default/user-session=dwm/g' /etc/lightdm/lightdm.conf &&
	echo " Lightdm setup is done!!" || echo " Something is happening!!!"

	sudo systemctl enable lightdm -f
	echo " Lightdm was enabled"
	echo ""
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
	imagemagick
	alsa-utils
	lm_sensors
	networkmanager
	rsync
	arandr
	xarchiver
	zip
	unzip
	tlp
	polkit
	polkit-gnome
	gnome-keyring
	libx11
	libxft
	gcc
	make
	libxinerama
	gtk-engine-murrine
	dunst
	libnotify
	adapta-gtk-theme
	papirus-icon-theme
	rxvt-unicode
	ttf-dejavu
   	noto-fonts
	vim
	amfora
	ranger
	calcurse
	amfora
	htop
	neofetch
	mpv
	w3m)

	sudo pacman -S --noconfirm --needed "${PKGS[@]}" &&
	echo " All utilities successfully Installed"
	echo ""
	sleep 2

	echo " Cloning YAY (AUR Helper)"
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	sudo rm -r yay
	echo ""
	sleep 2

	echo " Setting up Rangen File Manager"
	echo ""
	sleep 2

	ranger --copy-config=all

	sed -i 's/set preview_images false/set preview_images true/g' $HOME/.config/ranger/rc.conf &&
	echo " Preview images activated" || echo " Upsss!!!"
	echo ""

	sed -i 's/set draw_borders none/set draw_borders both/g' $HOME/.config/ranger/rc.conf &&
	echo " Draw borders activated" || echo  " Not Againg!!!"
	echo ""

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
	libreoffice-fresh
	nitrogen)

	sudo pacman -S --noconfirm "${PKGS[@]}" &&
	echo " GUI Applications Successfully installed" || echo " Something is not right!!!"
	echo ""

	while true; do
		read -p " Install Brave [y - n] : " yn
		case $yn in
			[Yy]* )
				yay -S brave-bin &&
				echo " Brave has been installed" || echo " Not Again!!!!" ; break ;;
			[Nn]* )
				break ;;
			* )
				echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " Install Chromium [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo pacman -S -noconfirm chromium &&
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
				sudo pacman -S --noconfirm firefox &&
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

	cp -ar config-files/configs/nmcli/ $HOME/.dwm/ &&
	echo " networkmanager demnu has been copied" || echo " We have a problem again!!!"
	echo ""
	sleep 5

	clear
	echo " ##### NEW DIRECTORIES AND CONFIG FILES ####"
	echo ""
	sleep 2

	cp -af config-files/configs/Xresources $HOME/.Xresources &&
	echo " New Xresources file has been copied" || echo " Againnnn!!!"
	echo ""

	cp -af config-files/configs/bash_profile $HOME/.bash_profile &&
	echo " New Bash Profile file has been copied" || echo " Againnnn!!!"
	echo ""

	cp -af config-files/configs/bashrc $HOME/.bashrc &&
	echo " New bashrc file has been copied" || echo " Againnnn!!!"
	echo ""
	sleep 2

	sudo cp -af config-files/configs/blurlock /usr/bin/ &&
	sudo chmod +x /usr/bin/blurlock &&
	echo " blurlock has been installed" || echo " Sorry!!!"
	echo ""

	sudo cp -af config-files/configs/dc-scrot /usr/bin/ &&
	sudo chmod +x /usr/bin/dc-scrot &&
	echo " Scrot config files have been installed" || echo " Again!!!"
	echo ""

	echo " Cloning and installing Dracula gtk theme"
	git clone https://github.com/dracula/gtk.git &&
	sudo mv gtk /usr/share/themes/Dracula &&
	sudo chmod +x -R /usr/share/themes/Dracula &&
	echo " Dracula gtk theme has been installed" || echo " No way!!!!"
	echo ""

	echo " Cloning and installing Dracula icons"
	git clone git://git.darknesscode.xyz/draculaicons &&
	sudo mv draculaicons /usr/share/icons/Dracula &&
	sudo chmod +x -R /usr/share/icons/Dracula &&
	echo " Dracula icons has been installed" || echo " Another problem!!!"
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
	echo "                    _     _      _                   "
	echo "     /\            | |   | |    (_)                  "
	echo "    /  \   _ __ ___| |__ | |     _ _ __  _   ___  __ "
	echo "   / /\ \ | '__/ __| '_ \| |    | | '_ \| | | \ \/ / "
	echo "  / ____ \| | | (__| | | | |____| | | | | |_| |>  <  "
	echo " /_/    \_\_|  \___|_| |_|______|_|_| |_|\__,_/_/\_\ "
	echo ""
	echo " Install the necessary utilities/software for a fresh install"
	echo ""
	echo " 1 - Upadate System"
	echo " 2 - Install"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; update  ; press_enter ;;
		2) clear; install ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
