# nixos-repo (desktop + WSL, modular, flakes)

Modular NixOS config with two hosts:
- `wsl` (NixOS-WSL, systemd-enabled) — builds everywhere.
- `desktop` (bare-metal Linux) — placeholder hardware config (replace with your machine's).

Layers:
- `hosts/` (tiny per-machine glue)
- `profiles/` (roles you compose)
- `modules/` (optional implementation modules; none included by default)
- `users/` (system users)
- `home/` (Home-Manager, as a NixOS module)
- `overlays/` & `pkgs/` (customizations)
- optional `secrets/` (sops-nix or agenix later)

> CI builds `wsl` only to avoid hardware-specific failures.
