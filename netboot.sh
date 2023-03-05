#!/bin/sh

version=101021

#Variables
timezone=Europe/Rome

root=sdb3
swap=sdb2
efi=sdb1
home=sda1

export LANG=en_US.UTF-8

echo "Arch Linux Installer"
echo "Version: $version"
echo "***YOU HAVE TO PARTITION THE DRIVES FIRST!***"

#Setting NTP and Timezone
timedatectl set-ntp true
timedatectl set-timezone $timezone

#Enabling multilib repository
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

#Refreshing repos
pacman -Sy 

#Creating file systems
mkfs.vfat -F32 /dev/$efi
mkswap /dev/$swap
mkfs.ext4 /dev/$root
#mkfs.ext4 /dev/$home

#Mounting root
mount /dev/$root /mnt

#Installing base software (replace amd-ucode with intel-ucode for intel-based systems)
pacstrap /mnt base base-devel linux linux-firmware linux-headers intel-ucode nano

#Creating EFI directory
mkdir /mnt/boot/efi

#Mounting additional file systems
mount /dev/$home /mnt/home
mount /dev/$efi /mnt/boot/efi
swapon /dev/$swap

#Generating fstab file
genfstab -U /mnt > /mnt/etc/fstab
