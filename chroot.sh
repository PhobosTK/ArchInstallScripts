#!/bin/sh

version=101021

#Variables
timezone=Europe/Rome

hostname=
user=

echo "Arch Linux Installer"
echo "Version: $version"
echo "***YOU HAVE TO PARTITION THE DRIVES FIRST!***"

#Setting NTP and Timezone
timedatectl set-ntp true
timedatectl set-timezone $timezone

#Enabling multilib repository
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

#Setting locale
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

export LANG=en_US.UTF-8

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=us" > /etc/vconsle.conf

#Generating locale
locale-gen

#Setting hostname
echo "$hostname" > /etc/hostname

#Setting hosts
echo "127.0.0.1       localhost" > /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain     $hostname" >> /etc/hosts
echo " " >> /etc/hosts

#Refreshing repos
pacman -Sy

#Setting root password
passwd

#---SOFTWARE INSTALLATION---

#Installing bootloader
pacman -S --noconfirm grub efibootmgr os-prober libisoburn fuse freetype2 mtools dosfstools
grub-install --target=x86_64-efi --bootloader-id=ArchSSD --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

#Installing X and video drivers (AMD)
#pacman -S --noconfirm xorg xorg-server xorg-apps xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau vulkan-icd-loader lib32-vulkan-icd-loader vulkan-tools vulkan-swrast vulkan-mesa-layers lib32-vulkan-mesa-layers

#Installing X and video drivers (Intel)
pacman -S --noconfirm xorg xorg-apps xorg-server mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader vulkan-tools vulkan-swrast libva-intel-driver lib32-libva-intel-driver vulkan-mesa-layers lib32-mesa-vdpau xterm lib32-vulkan-mesa-layers

#Installing lightdm
pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

#Installing DE
pacman -S --noconfirm xfce4 xfce4-goodies trash-cli gtk-engine-murrine adwaita-cursors

#Installing fonts
pacman -S --noconfirm ttf-liberation ttf-bitstream-vera adobe-source-sans-pro-fonts ttf-droid ttf-dejavu ttf-ubuntu-font-family

#Removing junk
pacman -R --noconfirm parole mousepad ristretto

#Installing "quality of life improvement" stuff
pacman -S --noconfirm btop htop p7zip unrar conky reflector zsh zsh-completions screen smartmontools neofetch neovim pkgstats ufw gufw clamav clamtk dmidecode tlp tlp-rdw

#Installing FS-related packages
pacman -S --noconfirm gvfs gvfs-smb gvfs-mtp gpart cabextract ntfs-3g jfsutils f2fs-tools exfatprogs reiserfsprogs udftools nilfs-utils tar gnome-disk-utility gparted baobab 

#Installing development-related packages
pacman -S --noconfirm git go jdk11-openjdk jdk17-openjdk python-setuptools python-pip python-wheel nodejs php netbeans npm groovy nginx

#Installing network-related packages
pacman -S --noconfirm rsync samba wget net-tools wpa_supplicant networkmanager dhclient net-tools network-manager-applet bluez bluez-tools bluez-libs bluez-utils bluez-hid2hci bluez-plugins blueman kismet aircrack-ng wireshark-cli wireshark-qt remmina filezilla firefox-developer-edition thunderbird chromium

#Installing VM-related packages
pacman -S libvirt virt-install qemu qemu-arch-extra

#Installing audio/video stuff
pacman -S --noconfirm sdl ffmpeg ffmpegthumbnailer gimp pulseaudio jack pulseaudio-alsa pavucontrol gst-plugins-bad gst-libav lib32-gst-plugins-base lib32-gst-plugins-base-libs lib32-gst-plugins-good lib32-sdl pulseaudio-jack pulseaudio-bluetooth sdl_mixer sdl2_mixer lib32-sdl_mixer lib32-sdl2_mixer lib32-alsa-plugins fluidsynth lib32-fluidsynth timidity++ lib32-jack libdvdcss gst-plugins-ugly v4l2loopback-dkms lib32-openal lib32-mpg123 lib32-libpng lib32-giflib lib32-gst-plugins-base lib32-gst-plugins-good wavpack libmad gst-libav libdvdnav libvorbis faac lame libmpeg2 libtheora libxv libdvdread a52dec faad2 flac jasper projectm-pulseaudio alsa-utils

#Installing software
pacman -S --noconfirm gedit gedit-plugins eog eog-plugins file-roller evince gnome-calculator ghex blender prusa-slicer libreoffice-fresh kicad kicad-library kicad-library-3d simplescreenrecorder lib32-simplescreenrecorder cheese audacity openshot obs-studio vlc clementine sane 

#Python modules
#pip install bluepy esptool yt-dlp wheel

#Enabling sevices
systemctl enable lightdm
systemctl enable NetworkManager
systemctl enable wpa_supplicant
systemctl enable bluetooth
#systemctl enable dhclient@wlo1
#systemctl enable dhclient@enp5s0

#Creating user
useradd -m -G wheel,audio,video,uucp,wireshark,kismet,games,input,kvm,libvirt,wireshark $username
passwd $username

#Creating autologin group and adding $username to it
groupadd -r autologin
gpasswd -a $username autologin
