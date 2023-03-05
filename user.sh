#!/bin/sh

version=101021

#Variables
#timezone=

export LANG=en_US.UTF-8

echo "Arch Linux Installer"
echo "Version: $version"
echo "***YOU HAVE TO PARTITION THE DRIVES FIRST!***"

#Setting NTP and Timezone
#timedatectl set-ntp true
#timedatectl set-timezone $timezone

#Installing yay
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay


#Installing drivers software
yay -S numix-gtk-theme-git numix-icon-theme-git ventoy-bin arch-install-scripts cups bluez-cups pamac-aur mkinitcpio-firmware t2scan af9015-firmware solaar hddtemp memtest86-efi gpsd

#Installing development software
yay -S intellij-idea-community-edition stm32cubeide pico-sdk pycharm-community-edition sublime-text-3 saleae-logic android-tools android-studio visual-studio-code-bin arduino ch341eepromtool openboardview openocd arduino-avr-core stlink zerynth-studio

#Installing games
yay -S steam steam-native-runtime gzdoom-git aisleriot dosbox alephone alephone-marathon axash3d-git nestopia darkplaces-rm-git hexen2 ioquake3-git quakespasm quakespasm-spiked-git raze-git vkquake wolf yamagi-quake2 yuzu-mainline-bin slade

#Installing web-related softwarex
yay -S qbittorrent telegram-desktop uget

#Installing networking-related software

yay -S nmap zenmap-python3-git mqtt-explorer-appimage mosquittotraceroute macchanger bind-tools

#Installing audio/video-related software
yay -S winff mplayer a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore handbrake webp-pixbuf-loader ifuse gtkpod soundfont-zelda3sf2 soundfont-opl3-fm-128m

#Installing VM software
yay -S vmware-workstation virtualbox virtualbox-guest-iso virtualbox-host-dkms virt-manager

#Installing Docker
yay -S docker

#Installing Wine(Proton)
yay -S proton-ge-custom protontricks wine-mono wine-gecko vkd3d-proton dxvk-bin lib32-libdxvk libdxvk

#Installing Thinkpad-related software
yay -S tlp tlp-rdw acpi_call thinkfan-git tpacpi-bat thinkfan-ui-git

#Installing AMD-related software
#yay -S zenpower-dkms zenmonitor

#Installing it87 module (for ite8686)
#git clone https://aur.archlinux.org/it87-dkms-git.git
#cd it87-dkms-git
#makepkg -si --noconfirm
#cd ..
#rm -rf it87-dkms-git

#Enabling DX11 & DX12 support 
#setup_dxvk install
#setup_vkd3d_proton install
