{ config, pkgs, lib, ... }:
{
  networking.hostName = "wsl";

  # WSL integration
  wsl.enable = true;
  wsl.defaultUser = "dev";
  wsl.useWindowsDriver = true;
  wsl.startMenuLaunchers = true;
  wsl.docker-desktop.enable = true;

  # GUI via WSLg; no X server needed
  services.xserver.enable = false;

  # Audio (WSLg)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
