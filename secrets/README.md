Optional secrets area. If you use sops-nix or agenix, place policy and encrypted
files here. This repo imports the sops-nix module but defines no secrets by
default, so builds won't fail if this folder is empty.
