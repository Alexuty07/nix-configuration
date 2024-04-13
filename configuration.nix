{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  # LUKS devices
  boot.initrd.luks.devices."luks-1ec6d49d-7a0b-4ac9-aaea-e8efc1c75ac0".device = "/dev/disk/by-uuid/1ec6d49d-7a0b-4ac9-aaea-e8efc1c75ac0";

  # Laptop power management
  services.thermald.enable = true
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
        };
  };


  # Autoupgrade
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Garbage collection
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  # Hostname
   networking.hostName = "nixos";

  # KDE Partition Manager
  programs.partition-manager.enable = true;

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";


  # WLAN
  networking.networkmanager.enable = true;

  # Tailscale
  services.tailscale.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # i18n
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # X11
  services.xserver.enable = true;

  # Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Automatic login (to avoid entering a second pasword)
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alexuty";

  # Keyboard settings (xkb)
  services.xserver.xkb = {
    layout = "es,us";
    options = "grp:win_space_toggle";
  };

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  # Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Touchpad support
  services.xserver.libinput.enable = true;

  # Virtualization with virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

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
      signal-desktop-beta
      tailscale-systray
      telegram-desktop
      tetrio-desktop
      texliveFull
      timer
      vesktop
      vlc
      waydroid
    ];
  };

  # Steam
  programs.steam.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    papirus-icon-theme
    qemu_kvm
    qmk
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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ]; # LocalSend
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPorts = [ 53317 ]; # LocalSend
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  system.stateVersion = "23.11";

}
