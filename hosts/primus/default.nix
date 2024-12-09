{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  # LUKS devices
  boot.initrd.luks.devices."luks-1ec6d49d-7a0b-4ac9-aaea-e8efc1c75ac0".device = "/dev/disk/by-uuid/1ec6d49d-7a0b-4ac9-aaea-e8efc1c75ac0";

  # Support for non-Nix executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    rustc
    rust-analyzer
    cargo
    makeWrapper
    clang
    pkg-config
    mold
    expat
    fontconfig
    freetype
    android-tools
    libxkbcommon
    libGL
    wayland
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libX11
  ];

  # Tailscale
  services.tailscale.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  # Virtualization with virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # User account. Set a password with ‘passwd’
  users.users.alexuty = {
    isNormalUser = true;
    description = "Álex Santiago";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      anki-bin
      audacity
      corefonts
      element
      firefox
      galaxy-buds-client
      gimp
      gitkraken
      gummi
     #itch (broken right now, try later)
      inkscape
      kate
      kdenlive
      kdePackages.kleopatra
      keepassxc
      libqalculate
      libreoffice
      meslo-lgs-nf
      monero-gui
      obsidian
      openutau
      prismlauncher
      protonmail-desktop
      protonvpn-gui
      qalculate-qt
      qbittorrent-qt5
      retroarch
      session-desktop
      signal-desktop-beta
      tailscale-systray
      telegram-desktop
      tetrio-desktop
      texliveFull
      timer
      vlc
      vesktop
      waydroid
    ];
  };

  # Steam
  programs.steam.enable = true;

  # Overlays
  nixpkgs.overlays = [(final: prev: {
    vesktop = prev.vesktop.override {
      withSystemVencord = false;
    };
  })];

  # System packages
  environment.systemPackages = with pkgs; [
    android-tools
    fastfetch
    filelight
    fortune-kind
    git
    htop
    hyfetch
    kdePackages.kdeconnect-kde
    localsend
    logitech-udev-rules
    microcodeIntel
    neofetch
    nerdfonts
    nfs-utils
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    papirus-icon-theme
    qemu_kvm
    qmk
    spice-gtk
    syncthing
    syncthingtray
    solaar
    tailscale
    tldr
    unipicker
    wget
    yakuake
    zsh
    zsh-powerlevel10k
  ];

  # OpenSSH daemon
  services.openssh.enable = true;

  # Android Containers
  virtualisation.waydroid.enable = true;

  # GnuPG
  programs.gnupg.agent.enable = true;
  services.pcscd.enable = true;

  system.stateVersion = "23.11";

}
