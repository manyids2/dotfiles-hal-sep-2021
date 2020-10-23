# first-install

sudo apt update
sudo apt upgrade


1. nvidia drivers
sudo add-apt-repository ppa:graphics-drivers/ppa

ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

check:  nvidia-smi

Fri Oct 23 08:00:59 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 455.23.04    Driver Version: 455.23.04    CUDA Version: 11.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce GTX 166...  Off  | 00000000:01:00.0  On |                  N/A |
|  0%   43C    P8    13W / 125W |    218MiB /  5941MiB |      1%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A       746      G   /usr/lib/xorg/Xorg                 35MiB |
|    0   N/A  N/A      1261      G   /usr/lib/xorg/Xorg                 71MiB |
|    0   N/A  N/A      1386      G   /usr/bin/gnome-shell              101MiB |
+-----------------------------------------------------------------------------+

	lshw -c video
	  *-display                 
       description: VGA compatible controller
       product: TU116 [GeForce GTX 1660 SUPER]
       vendor: NVIDIA Corporation
       physical id: 0
       bus info: pci@0000:01:00.0
       version: a1
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress vga_controller bus_master cap_list rom
       configuration: driver=nvidia latency=0
       resources: irq:138 memory:de000000-deffffff memory:c0000000-cfffffff memory:d0000000-d1ffffff ioport:e000(size=128) memory:c0000-dffff

terminal stuff-

alacritty 
sudo apt install curl

curl https://sh.rustup.rs -sSf | sh
Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  /home/x/.rustup

This can be modified with the RUSTUP_HOME environment variable.

The Cargo home directory located at:

  /home/x/.cargo

This can be modified with the CARGO_HOME environment variable.

The cargo, rustc, rustup and other commands will be added to
Cargo's bin directory, located at:

  /home/x/.cargo/bin

This path will then be added to your PATH environment variable by
modifying the profile file located at:

  /home/x/.profile

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: x86_64-unknown-linux-gnu
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes


(Git)
sudo apt install git

(alacritty)
git clone https://github.com/alacritty/alacritty.git
cd alacritty

	(for wayland)
sudo apt install libegl1-mesa-dev
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
infocmp alacritty

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
(need to do completions part)

(tmux)
sudo apt install tmux

(i3)
sudo apt install i3 i3blocks

(typora)
# or use
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -

# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update

# install typora
sudo apt-get install typora

# utils
sudo apt install tree
lshw - information about hardware configuration  
lshw-gtk - graphical information about hardware configuration  


[stow](https://bastian.rieck.me/blog/posts/2019/dotfiles_stow/)

# qutebrowser - installs qt5 stuff as well
sudo apt install qutebrowser

# feh, zathura, mpd, etc
sudo apt install feh
sudo apt install zathura
sudo apt install mpd
sudo apt install ncmpcpp
sudo apt install flameshot
sudo apt install ranger

# fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish

# nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update

# i3 config:
DO NOT copy from /etc/i3/config to ~/.config/i3
start i3, and let it initialize

# rofi
sudo apt install rofi

# nvim config


# git flow
sudo apt install git-flow
cp https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git.fish to 
.config/fish/completions

# starting gnu stow stuff 
sudo apt install stow
 - it actually works!

# lazygit
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
