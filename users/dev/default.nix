{ pkgs, ... }:
{
  users.users.dev = {
    isNormalUser = true;
    description = "dev";
    extraGroups = [ "wheel" "docker" "audio" "video" "input" ];
    shell = pkgs.bashInteractive;
  };

  # Passwordless sudo for wheel (adjust to taste)
  security.sudo.wheelNeedsPassword = false;
}
