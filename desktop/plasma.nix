{config, pkgs, ...}:
{
  services.desktopManager.plasma6.enable = true;
  programs.partition-manager.enable = true;
  services.xserver.xkb = {
    layout = "es,us";
    options = "grp:win_space_toggle";
  };
}
