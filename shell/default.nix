{config, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  users.defaultUserShell = pkgs.zsh;
}
