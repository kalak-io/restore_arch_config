#! /usr/bin/env bash

PACKAGES=(
    git
    base-devel
    a52dec
    faac
    faad2
    flac
    jasper
    lame
    libdca
    libdv
    libmad
    libmpegu
    libtheoru
    libvorbiu
    libxv
    wavpack
    x264
    xvidcore
    gstreamer0.10-plugins
    pamac-cli
    vlc
    libreoffice
    terminator
    firefox
    firefox-developer-edition
    chromium
    aria2
    p7zip
    p7zip-plugins
    unrar
    tar
    rsync
    htop
    the_silver_searcher
    intel-ucode
    zsh
    linux-firmware
    vim
    docker
    xclip
    fzf
    python-pip
    python-virtualenv
    transmission-gtk
    tree
    gparted
    android-tools
    nodejs
    npm
    curl
    cmake
    make
)

# Choose pacman-mirrors
sudo pacman-mirrors -f 0 && sudo pacman -Syy

# Remove useless packages
yes | sudo pacman -R hplip cups splix
sudo systemctl disable avahi-daemon

# Update
yes | sudo pacman -Syu

# Install base packages
yes | sudo pacman -S ${PACKAGES[*]}

# Install AUR packages
yes | sudo pamac install ttf-ms-fonts ufw tlp preload slack-desktop

# Install programs
for f in programs/arch/*.sh; do
    bash "$f" -H;
done

# Configure ZRAM
yes | pamac install systemd-swap
sudo systemctl enable systemd-swap.service
sudo bash -c 'echo -e "zswap_enabled=1\nzram_enabled=0\nswapfc_enabled=1" > /etc/systemd/swap.conf.d/myswap.conf'

# Configure Docker
sudo usermod -aG docker $LOGNAME
sudo docker run hello-world

# Set swapiness
sudo echo vm.swappiness=10 > /etc/sysctl.d/100-manjaro.conf
sudo swapoff -a
sudo swapon -a

# Enable Preload
sudo systemctl enable preload

# Enable Firewall
sudo systemctl enable ufw.service
sudo ufw enable

# Enable TRIM
sudo systemctl enable fstrim.timer

# Enable TLP
sudo systemctl enable tlp --now

# Configure pacman with aria2
sudo echo "XferCommand = /usr/bin/aria2c --allow-overwrite=true --continue=true --file-allocation=none --log-level=error --max-tries=2 --max-connection-per-server=2 --max-file-not-found=5 --min-split-size=5M --no-conf --remote-time=true --summary-interval=60 --timeout=5 --dir=/ --out %o %u" >> /etc/pacman.conf
