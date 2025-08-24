{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  # Extras for a desktop user session
  home.packages = with pkgs; [
    firefox
    gnome.gnome-tweaks
  ];
}
