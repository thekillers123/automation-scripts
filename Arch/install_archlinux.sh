#!/bin/bash

# mount root partation to /mnt
# mount efi partation to </mnt/boot/efi>
# pacstrap /mnt base base-devel
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt

########################################
echo "Setup time zone <Chicago time>"
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

########################################
echo "Setup language <EN-US UTF-8>"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

########################################
echo "Hostname <zach-arch>"
echo "zach-arch" >> /etc/hostname

########################################
echo "Set root password"
passwd

########################################
echo "Install bootloader"
echo "efi partation </boot/efi>"
pacman -S grub efibootmgr intel-ucode
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

########################################
echo "Install zsh, nano, sudo, and xdg-user-dirs"
pacman -S zsh nano sudo xdg-user-dirs

########################################
echo "Add user <rookie>"
useradd -m -G wheel -s /bin/zsh rookie
passwd rookie

########################################
echo "Install plasma"
pacman -S plasma-meta kde-applications-meta 

########################################
echo "Enable servers"
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable bluetooth

########################################
echo "Install chromium"
pacman -S chromium
