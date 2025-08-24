{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc gnumake
    gnupg
    openssh
    nil
    nixfmt-classic
  ];

  programs.ssh.startAgent = true;
}
