{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "desktop";

  # Desktop session
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  hardware.opengl.enable = true;

  # Native Docker
  virtualisation.docker.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
