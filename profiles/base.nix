{ pkgs, lib, ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Etc/UTC";

  environment.systemPackages = with pkgs; [
    git htop curl wget ripgrep fd bat
  ];

  # Quality-of-life
  programs.command-not-found.enable = false;
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  # Optional overlays (pkgs/overlays)
  nixpkgs.overlays = [ (import ../overlays) ];

  # Baseline system version
  system.stateVersion = "25.05";
}
