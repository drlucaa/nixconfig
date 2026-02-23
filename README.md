# Nix-Darwin Configuration

This repository contains my declarative macOS system and dotfiles configuration.
It is built using [Nix](https://nixos.org/),
[nix-darwin](https://github.com/LnL7/nix-darwin), and
[Home Manager](https://github.com/nix-community/home-manager) (flake-based).

## Hosts

Currently, this flake manages the configurations for the following macOS
machines:

- `lucas-macbook`
- `dv-macbook`
- `mac-mini`

## Usage

To apply the configuration for a specific host, run the following command from
the root of this repository:

```bash
darwin-rebuild switch --flake .#<hostname>
```

> [!TIP]
> Once installed, you can also use the configured `nrs` shell alias to quickly
> rebuild and switch the configuration for your current host.
