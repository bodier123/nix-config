{ config, pkgs, ... }:
{
  home.username = "dev";
  home.homeDirectory = "/home/dev";

  programs.git = {
    enable = true;
    userName = "dev";
    userEmail = "dev@example.com";
  };

  programs.zsh.enable = true;
  programs.starship.enable = true;

  home.packages = with pkgs; [
    tmux
    neovim
    tree
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.stateVersion = "25.05";
  programs.nushell.enable = true;
}
