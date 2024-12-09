{config, pkgs, ...}:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Keyboard settings (console)
  console.keyMap = "es";
}
