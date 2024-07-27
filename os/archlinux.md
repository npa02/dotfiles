# ArchLinux

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
* [General guide](#general-guide)
* [Customization and tinkering](#customization-and-tinkering)
  * [Applications](#applications)
  * [Setting up `GPU` for deep learning](#setting-up-gpu-for-deep-learning)
  * [TROUBLE-SHOOTING](#trouble-shooting)

<!-- vim-markdown-toc -->

## Installation

- [To cleanly remove Windows](https://www.daangeurts.nl/blog/removing-windows-and-installing-arch-linux/)
- Check [Arch Linux wiki installation guide](https://wiki.archlinux.org/title/Installation_guide).
- Example videos: [1](https://youtu.be/HpskN_jKyhc), [2](https://youtu.be/cM2UDz8BepU), [3](https://youtu.be/DPLnBPM4DhI)
- **Note:** If you intend to use many Linux `distro`s, consider having a separate `/home` partition

0. Set font

   ```bash
   setfont /usr/share/kbd/consolefonts/ter-c20b...
   ```

1. Get the latest `iso` to USB thumb drive as a boot device
2. Could skip `iso` image verification, setting console keyboard layout
3. Verify boot mode:

   ```bash
   cat /sys/firmware/efi/fw_platform_size
   ```

   - If the command returns `64`, system boots in `64-bit x64 UEFI`
   - If the command returns `32`, system boots in `32-bit IA32 UEFI`
   - If the file doesn't exist, system boots in `BIOS` or `CSM` mode.

4. Setup network connection

   ```bash
   ip link
   iwctl
   [iwd]# device list
   [iwd]# station device_name scan
   [iwd]# station device_name get-networks
   [iwd]# station device_name connect SSID_name
   Ctrl+D to exit [iwd]
   ping archlinux.org
   ```

5. Update system clock

   ```bash
   timedatectl set-ntp true
   timedatectl status #to check
   ```

6. Partition the disks

   ```bash
   lsblk              # to view Partitions
   cgdisk /dev/sda    # choose the largest Partition
   gdisk -l /dev/sda  # check if it's GPT or MBR
   ```

   - Create new partitions:
     - Boot partition, only for `UEFI` boot mode, not `BIOS`: first sector - `default`, second sector - `1G`, hex code - `ef00`, name - `boot`
     - Swap partition: first sector - `default`, second sector - `20G`, hex code - `8200`, name - `swap`.
       - **Note:** 20Gb swap for 16Gb of RAM, 35Gb swap for 32Gb of RAM.
       - Check RAM size with: `free -ght`
     - File system: first sector - `default`, second sector - `default`, hex code - `8300`, name - `root`
   - Format partitions

     ```bash
     mkfs.fat -F 32 /dev/boot_partition
     mkswap /dev/swap_partition
     mkfs.ext4 /dev/root_partition
     ```

   - Mount partitions

     ```bash
     mount /dev/root_partition /mnt
     swapon /dev/swap_partition
     mkdir -p /mnt/boot
     mount /dev/boot_partition /mnt/boot
     ```

7. Package Installation

   ```bash
   vim /etc/pacman.d/mirrorlist # Clean up the mirrorlist
   vim /etc/pacman.conf # ParallelDownloads = 14
   pacstrap -KP /mnt base base-devel linux(-lts) linux-headers linux-firmware \
       sof-firmware iw iwd vim grub efibootmgr openssh git intel-ucode
   ```

8. Configure the system

   ```bash
   genfstab -U /mnt >> /mnt/etc/fstab
   arch-chroot /mnt # enter system, to exit: exit

   # Set time zone, region/city is Europe/Berlin, check with Tab
   ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
   hwclock --systohc

   vim /etc/locale.gen # en_US.UTF-8 UTF-8
   locale-gen
   echo "LANG=en_US.UTF-8" > /etc/locale.conf
   echo "computer_name" > /etc/hostname

   mkinitcpio -P # (as long as the commands exit successfully)
   passwd # set root password
   ```

9. Create `bootloader`

- For `BIOS`, please refer to these tutorials:

  - `GPT`: [`Rouchage`](https://youtu.be/2YshYiYsvKA?si=PSiv8AeWSEZjEhwq)
  - `MBR`: [`DWIX`](https://youtu.be/7FD3gh8mLME?si=HWI_2UroJBEKcAyw)

- For `UEFI`:

  ```bash
  # pacman -Sy grub efibootmgr
  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
  # Edit GRUB default time out
  sudo vim /etc/default/grub
  grub-mkconfig -o /boot/grub/grub.cfg

  exit # Exit and reboot. Pull out the flash drive.
  shutdown -r now
  ```

10. Setup network connection:

    - Login as root

      ```bash
      # show network device names (one wired and one wireless carrier)
      networkctl list

      sudo systemctl enable --now iwd
      iwctl
      ```

    - Create `config` files, with names of devices from the preceding:

      - Wired adapter: `/etc/systemd/network/20-wired.network`

        ```txt
        [Match]
        Name=eno1
        [Network]
        DHCP=yes
        [DHCP]
        RouteMetric=10
        ```

      - Wireless adapter: `/etc/systemd/network/25-wireless.network`

        ```txt
        [Match]
        Name=wlan0
        [Network]
        DHCP=yes
        [DHCP]
        RouteMetric=20
        ```

    - Enable and start the `systemd` services:

      ```bash
      systemctl enable --now systemd-networkd
      systemctl enable --now systemd-resolved
      ping google.com
      ```

11. Create users:

    ```bash
    useradd -g users -G wheel,storage,power,audio,video,optical -m user_name
    passwd user_name
    # ln -svf /usr/bin/vim /usr/bin/vi
    visudo # uncomment %wheel ALL NOPASSWD ALL, can sudo without passwd

    # if openssh installed
    systemctl enable --now sshd
    ip addr
    ```

12. Drivers and packages installation:
    Clone the `dotfiles` and run the script:

    ```bash
    vim /etc/pacman.conf # ParallelDownloads = 14, Include multilib
    # lspci -v | grep -A1 -e VGA -e 3D
    sudo pacman -S xf86-video-intel nvidia(-dkms) nvidia-utils # choose suitable graphic drivers
    cd ~ && git clone https://github.com/duken72/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles/pkg && ./pacman_install.sh
    ```

13. Post-installation: Setting up desktop environment\

    - Example videos: [vid_1](https://youtu.be/DAmXKDJ3D7M), [vid_2](https://youtu.be/eHdP4sT7-8U), [vid_3](https://youtu.be/FudOL0-B9Hs).

      ```bash
      systemctl enable lightdm
      systemctl list-unit-files --state=enabled
      reboot
      ```

    - Go to <https://archlinux.org/mirrorlist>, choose only `https`, not `http`, just `IPv4`, not `IPv6`, use mirror status.
      Remember to un-comment the server names, then resynchronize.

    - To provide domain name resolution for software that reads `/etc/resolv.conf`:

      ```bash
      sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
      ```

---

## General guide

- [PACMAN](https://youtu.be/HD7jJEh4ZaM)
- [`AUR` Helper - `aura`](https://youtu.be/xPRJWHghWM8)
- [Tiling Window Managers](https://youtu.be/Obzf9ppODJU)
- [Dual boot with Ubuntu](https://www.linuxandubuntu.com/home/dual-boot-ubuntu-and-arch-linux)

---

## Customization and tinkering

- [Steam custom Proton GE](https://github.com/GloriousEggroll/proton-ge-custom#native)
- Manage `XFCE` window manager hotkeys
- Window manager theme: [True Minimalist](https://www.xfce-look.org/p/1016640/) and [guide to install](https://wiki.xfce.org/howto/install_new_themes)
- Fonts: [JetBrainsNL Mono Nerd](https://archlinux.org/packages/community/any/ttf-jetbrains-mono-nerd/), size 11-12
- Mouse cursor: [Night Diamond theme](https://www.gnome-look.org/p/1295073/) and [Wiki guide](https://wiki.archlinux.org/title/Cursor_themes#XFCE)
- [`polybar`](https://github.com/polybar/polybar): check wiki, also nice reference from [AbdelrhmanNile](https://github.com/AbdelrhmanNile/mydots_bspwm)
- Ranger: [image preview with `ueberzug`](https://github-wiki-see.page/m/ranger/ranger/wiki/Image-Previews), [video thumbnail with `ffmpeg`](https://www.reddit.com/r/NixOS/comments/74wftw/video_previews_wranger/), [docx2txt](http://docx2txt.sourceforge.net/)
- `zsh` with terminator and [Powerlevel10k](https://dev.to/web3coach/best-terminal-setup-terminator-zsh-powerlevel10k-7pl)
- [Move between monitors](https://github.com/calandoa/movescreen)
- [Redshift](https://wiki.archlinux.org/title/redshift) and [Backlight](https://wiki.archlinux.org/title/backlight)
- Missing keyboard volume control: [Arch wiki](https://wiki.archlinux.org/title/Keyboard_input) and [pulseaudio-ctl](https://github.com/graysky2/pulseaudio-ctl) get the key code with `showkey`, then setup keyboard shortcut to a `pulseaudio-ctl` command
- Unibus-vn: [enable macro](https://github.com/vn-input/ibus-unikey/issues/11)
- [Rolling back updates](https://linuxconfig.org/how-to-rollback-pacman-updates-in-arch-linux)
- Setting up [cleaning hooks](https://averagelinuxuser.com/clean-arch-linux/#1-clean-package-cache)
- [`pacman` Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Back_up_the_pacman_database)
- Replacement for `G-HUB`: [`Libratbag`](https://womanonrails.com/logitech-g915-tkl), and maybe [piper](https://github.com/libratbag/piper) as frontend app
- A bit troublesome with the [`Osmos` theme](https://github.com/Warinyourself/lightdm-webkit-theme-osmos)
- Terminus fonts as console font: put `vconsole.conf` in `/etc`

### Applications

- email client in terminal: [Alpine](https://alpineapp.email/) [bcacciaaudio.com](https://bcacciaaudio.com/2018/10/09/alpine-mail-setup-with-gmail/), [salixos.org](https://docs.salixos.org/wiki/How_to_set_up_Alpine_with_a_Gmail_account), [linuxshelltips.com](https://www.linuxshelltips.com/alpine-gmail-imap-in-linux/), [wesleyac.com](https://blog.wesleyac.com/posts/setting-up-alpine-gmail-with-arch-linux)
- Desktop system monitoring: [`conky`](https://github.com/brndnmtthws/conky), a fork from [`xypnox`](https://github.com/xypnox/dotfiles)
- Download manager: [`xdman`](https://xtremedownloadmanager.com/), [youtube-dl](https://youtube-dl.org/)
- Online meeting: `zoom`
- Cleaning: `trash-cli`, `rmlint`
- Bluetooth: `blueberry`, `bluez-utils`

---

### Setting up `GPU` for deep learning

Follow this [guide](https://jaggu-iitm.medium.com/setting-up-deep-learning-with-cuda-tensorflow-and-keras-on-arch-linux-with-dual-gpu-nvidia-gpu-82963d2ecb75)

- You don't need to install and use `bumblebee`, `optimus-manager` or `prime` to use the GPU, from either Intel or NVIDIA, for DL with `pytorch`/`tensorflow`

  ```bash
  sudo pacman -S cuda cudnn nvidia-dkms nvidia-utils \
      python-tensorflow-opt-cuda python-pytorch-opt-cuda
  ```

- Check in Python:

  ```python
  from tensorflow.python.client import device_lib
  device_lib.list_local_devices()
  import tensorflow as tf
  tf.config.list_physical_devices('GPU')

  import torch
  torch.cuda.is_available()
  ```

---

### TROUBLE-SHOOTING

- [No sound to speakers](https://bbs.archlinux.org/viewtopic.php?id=199067&p=2)
- [Wi-Fi rtl8821ce driver problem](https://github.com/tomaspinho/rtl8821ce)
