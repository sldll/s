#!/bin/bash
set -euo pipefail

sleep 0.2

echo
echo "🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀"
echo

HOST=ubuntu
CNTRY=NL
R="Europe/Amsterdam"

HDD=nvme0n1
DISK="/dev/$HDD"
EX=p
CR=crt
SIZE1=+500M
SIZE2=+80G
SIZE3=

sgdisk -Z $DISK

sgdisk -n 1::$SIZE1 -t 1:EF00 -c 1:"EFI" $DISK
sgdisk -n 2::$SIZE2 -t 2:8300 -c 2:"ROOT" $DISK
sgdisk -n 3::$SIZE3 -t 3:8300 -c 3:"B" $DISK

read -rp "user: " USERNAME
while true; do
    read -rsp "pswd: " PASSWORD
    echo
    read -rsp "pswd: " PASSWORD_CONFIRM
    echo
    if [ "$PASSWORD" = "$PASSWORD_CONFIRM" ]; then
        break
    else
        echo "pswd mismatch"
    fi
done

reflector -c "$CNTRY" -p https --age 4 --latest 15 --save /etc/pacman.d/mirrorlist

sed -i 's/^SigLevel.*/SigLevel = Never/' /etc/pacman.conf
sed -i 's/^LocalFileSigLevel.*/LocalFileSigLevel = Never/' /etc/pacman.conf
sed -i '/^\[options\]/a Color' /etc/pacman.conf

cryptsetup luksFormat --batch-mode ${DISK}${EX}2
cryptsetup luksOpen ${DISK}${EX}2 $CR

mkfs.fat ${DISK}${EX}1
mkfs.ext4 /dev/mapper/$CR

mount /dev/mapper/$CR /mnt
mount -o umask=0077 -m ${DISK}${EX}1 /mnt/boot

fallocate -l 8G /mnt/sf
chmod 600 /mnt/sf
mkswap /mnt/sf
swapon -p 10 /mnt/sf

pacstrap -KP /mnt base

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt bash <<😈
set -e

pacman -S --noconfirm mkinitcpio

sed -i 's/^HOOKS=.*/HOOKS=(base udev autodetect microcode modconf keyboard block encrypt filesystems)/' /etc/mkinitcpio.conf

curl -LO https://github.com/sldll/s/raw/main/pk
grep -v '^\s*#' pk | pacman -S --needed --noconfirm -

echo "root:$PASSWORD" | chpasswd

useradd -mG wheel $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

sed -i 's/fmask=0022,dmask=0022/umask=0077/' /etc/fstab
sed -i '/\bext4\b/ s/\brelatime\b/noatime/g' /etc/fstab

bootctl install
echo "title ubuntu" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options cryptdevice=/dev/nvme0n1p2:$CR root=/dev/mapper/$CR rw splash intel_pstate=disable" >> /boot/loader/entries/arch.conf

echo "[zram0]" >> /etc/systemd/zram-generator.conf
echo "zram-size = ram / 2" >> /etc/systemd/zram-generator.conf
echo "compression-algorithm = lz4" >> /etc/systemd/zram-generator.conf
echo "swap-priority = 100" >> /etc/systemd/zram-generator.conf

mkdir -p /etc/systemd/coredump.conf.d/
echo "[Coredump]" >> /etc/systemd/coredump.conf.d/custom.conf
echo "Storage=none" >> /etc/systemd/coredump.conf.d/custom.conf
echo "ProcessSizeMax=0" >> /etc/systemd/coredump.conf.d/custom.conf

echo "vm.swappiness=60" >> /etc/sysctl.d/99-swappiness.conf

echo "GTK_THEME=Adwaita:dark" >> /etc/environment

echo "LENOVO_BAT_CONSERVATION_MODE=1" >> /etc/tlp.conf
echo "START_CHARGE_THRESH_BAT0=75" >> /etc/tlp.conf

echo "$HOST" >> /etc/hostname

ln -sf /usr/share/zoneinfo/$R /etc/localtime
hwclock --systohc

systemctl enable NetworkManager
systemctl enable fstrim.timer
systemctl mask systemd-rfkill.service systemd-rfkill.socket
systemctl enable tlp
systemctl enable tlp-pd

su - $USERNAME -c 'git clone https://github.com/sldll/s dot'

echo
echo "🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀🥵💀"
echo

😈
