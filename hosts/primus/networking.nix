{ config, pkgs, ... }:

{
  networking = {
    hostName = "primus";
    networkmanager.enable = true;
    firewall = {
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
  };
}
