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
#        FILE: debian.sh
#       USAGE: ./debian.sh
#
# DESCRIPTION: install utilities and software in debian based systems
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 07-09-20 10:46
#
# -----------------------------------------------------------------

update_debian() {
	echo ""
	echo " Updating Debian"
	echo ""
	sleep 2;

	sudo apt update && sudo apt dist-upgrade -y &&
	echo ""
	echo " Debian Updated"
	echo ""
}

install() {
	echo ""
	echo " ##### XORG DISPLAY SERVER #####"
	echo ""
	sleep 2

	PKGS=(xorg
	lightdm
	slick-greeter)

	sudo apt install -y "${PKGS[@]}" &&
	echo " xorg and lightdm successfully installed"
	echo ""

	sudo cp -af config-files/configs/slick-greeter.conf /etc/lightdm/ &&
	echo " New slick greeter has been copied" || echo " Upss!!!!"
	sleep 5

	clear
	echo ""
	echo " ##### INSTALLING CLI AND OTHER SOFTWARE #####"
	echo ""
	sleep 2

	PKGS=(libxcursor1
	libdbus-glib-1-dev
	libxft-dev
	libdbus-1-dev
	libx11-dev
	libxinerama-dev
	libxrandr-dev
	libxss-dev
	libglib2.0-dev
	libpango1.0-dev
	libgtk-3-dev
	libxdg-basedir-dev
	libnotify-dev
	wget
	curl
	apt-transport-https
	scrot
	j4-dmenu-desktop
	xautolock
	i3lock
	imagemagick
	alsa-utils
	build-essential
	xautolock
	lm-sensors
	volumeicon-alsa
	network-manager
	pk-update-icon
	xarchiver
	tlp
	dunst
   	libnotify-bin
	adapta-gtk-theme
	rxvt-unicode
	vim-nox
	ranger
	calcurse
	htop
	mplayer
	w3m
	w3m-img)

	sudo apt install -y "${PKGS[@]}" &&
	echo " Everything looks good so far" || echo " Something goes wrong!"
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
	nitrogen)

	sudo apt install -y "${PKGS[@]}" &&
	echo " GUI Applications Successfully installed" || echo " Something is not right!!!"
	echo ""

	while true; do
		read -p " Install Brave Web Browser [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo apt install apt-transport-https curl &&
				curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - &&
				echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list &&
				sudo apt update &&
				sudo apt install brave-browser &&
				echo " Brave browser has been installed" || echo " We have a problem in the Matrix!!!" ; break ;;
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
				sudo apt install firefox-esr &&
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
	echo " Installing dwm"
	sleep 2

	cd config-files/systems/dwm/
	sudo make clean install
	cd ../../..

	clear
	echo ""
	echo " Installing dmenu"
	echo ""
	sleep 2

	cd config-files/systems/dmenu
	sudo make clean install
	cd ../../..

	clear
	echo ""
	echo " Installing slstatus, status bar for dwm"
	echo ""
	sleep 2

	cd config-files/systems/slstatus
	sudo make clean install
	cd ../../..
	sleep 2

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
	cp -af config-files/configs/Xresources $HOME/.Xresources &&
	echo " New Xresources file has been copied" || echo " Againnnn!!!"

	cp -af config-files/configs/bash_profile $HOME/.bash_profile &&
	echo " New Bash Profile file has been copied" || echo " Againnnn!!!"
	echo ""
	sleep 5

	clear
	echo ""
	echo " ##### NEW DIRECTORIES AND CONFIG FILES ####"
	echo ""
	sleep 2

	cp -af config-files/configs/bashrc $HOME/.bashrc &&
	echo " New bashrc file has been copied" || echo " Againnnn!!!"
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

	echo " Cloning and installing Dracula gtk theme"
	git clone https://github.com/dracula/gtk.git &&
	sudo mv gtk /usr/share/themes/Dracula &&
	sudo chmod +x -R /usr/share/themes/Dracula &&
	echo " Dracula gtk theme has been installed" || echo " No way!!!!"
	echo ""

	echo " Cloning and installing Dracula icons"
	git clone git://git.darknesscode.com/draculaicons.git &&
	sudo mv draculaicons /user/share/icons/Dracula &&
	sudo chmod +x -R /usr/share/icons/Dracula &&
	echo " Dracula icons has been installed" || echo " Another problem!!!"
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
	echo "  _____       _     _              "
	echo " |  __ \     | |   (_)             "
	echo " | |  | | ___| |__  _  __ _ _ __   "
	echo " | |  | |/ _ \ '_ \| |/ _' | '_ \  "
	echo " | |__| |  __/ |_) | | (_| | | | | "
	echo " |_____/ \___|_.__/|_|\__,_|_| |_| "
	echo ""
	echo " A build start for Debian with only the necessay"
	echo ""
	echo " 1 - Update Debian"
	echo " 2 - Install"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; update_debian ; press_enter ;;
		2) clear; install       ; press_enter ;;
		3) clear; printer-samba ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
