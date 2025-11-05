# NixOS Configuration

This repository contains the NixOS configuration for my systems (flake-based).

## Fresh installation (from the NixOS live ISO)

> **Heads-up:** The Disko step will **destroy all data** on the target disk. Double-check the selected host/target before running it.

### 1) Connect to Wi-Fi (if needed)

Start `wpa_supplicant`:

```bash
sudo systemctl start wpa_supplicant
```

Open the interactive client:

```bash
wpa_cli
```

Add and enable your network:

```bash
add_network
set_network 0 ssid "<SSID>"
set_network 0 psk "<PSK>"
enable_network 0
quit
```

You can confirm connectivity with:

```bash
ping nixos.org
```

### 2) Partition, format, and mount with Disko

Run Disko to destroy, format, and mount according to the flake profile for your host:

```bash
sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/disko#disko -- \
  --mode destroy,format,mount \
  --flake github:drlucaa/niconfig#<HOST>
```

Replace `<HOST>` with the desired host entry from this repo (e.g. `laptop`, `desktop`, …).
After this step your target filesystem(s) should be mounted under `/mnt`.

### 3) Create and activate swap (live environment)

If your layout includes a swap file subvolume at `/.swapvol/swapfile`, create and enable it now so the install has swap available:

```bash
sudo mkswap /mnt/.swapvol/swapfile
sudo swapon /mnt/.swapvol/swapfile
```

(Optional) verify:

```bash
swapon --show
```

> Note: Your flake may already configure the swap file for the installed system. The commands above just activate it **in the live installer**; on first boot, NixOS will manage it per your configuration.

### 4) Install NixOS using this flake

```bash
sudo nixos-install --flake github:drlucaa/niconfig#<HOST>
```

When it completes:

```bash
sudo reboot
```

### 5) First boot

* Log in as root, then set a password for the new user:

  ```bash
  passwd <USERNAME>
  ```
---

## Tips & troubleshooting

* If `wpa_cli` can’t associate, check SSID/PSK quoting and try:

  ```bash
  select_network 0
  reassociate
  status
  ```
* If Disko fails, make sure the `<HOST>` entry exists in the flake and that the target disk identifier matches what your host module expects (e.g., `/dev/nvme0n1` vs `/dev/sda`).
