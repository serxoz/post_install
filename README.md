### Linux Systems

The best thing about **Linux** is that you can install just a bases system or a full desktop enviroment. In here we like a minimal install of our linux and we use a *Tiling Window Manager*.

If you are new to this kind of installations and you don't know where to start, here is a list of tutorials that can help you to start with:

* Arch Linux - >
	* [Official Guide](https://wiki.archlinux.org/index.php/installation_guide)
	* [Guide 2](https://arcolinuxd.com/5-the-actual-installation-of-arch-linux-phase-1-uefi/)
* Debian ->
	* [Official Guide](https://www.debian.org/releases/stable/amd64/index.en.html) Debian is very easy to install.
* Void Linux ->
	* [Official Guide](https://docs.voidlinux.org/installation/live-images/guide.html)
	* [Guide 2](http://www.troubleshooters.com/linux/void/quickinst.htm)

# Post Installation

This is the script i use in my post installation. I use it for this *Linux Distros*:

* Arch Linux
* Debian
* Void Linux

In this script **dwm** is my default tiling window manager to install. (you can comment out or delete the lines that install dwm if you don't want to install it)

This is the suckless software that will be install

* dwm
* dmenu
* slstatus
* st

## Process

This script will install all you need to start with a new Linux system. Some distros need more software than other ones.

Here is a brief list of the software that will install:

* xorg
	* xorg-server
	* xorg-fonts
	* lightdm
	* lightdm-mini-greeter (**Void Linux**)
	* slick-greeter (**Arch Linux**, **Debian**)
* System Utilities
	* Libreries and all that stuffs
* CLI Programs
	* rxvt-unicode (i like this terminal)
	* st (i like this one as well)
	* ranger
	* vim
	* neofetch
* GUI Programs
	* lxappearance
	* nitrogen
	* xfce4-appfinder
	* xfce4-porwer-manager
	* pcmanfm (that is what i like)
	* nousepad
	* gimp
	* calibre
	* sigil
	* brave (**Arch Linux** and **Debian**)
	* chromium
	* firefox

Before you use the script, take a well look of it and change what ever you want to match your necesities for your own build.

### Note

Added [NetworkManager-dmenu](https://github.com/firecat53/networkmanager-dmenu) From Firecat53 repo.
