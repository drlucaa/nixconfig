# My NixOS configuration

This directory containes the NixOS configuration for my system

## Fresh Installation

### Wifi config (if needed)

First start the wpa_supplicant:
```bash
sudo systemctl start wpa_supplicant
```

then start the interactive wpa_cli:
```bash
wpa_cli
```

add a new network and set ssid and psk for the new network:
```bash
add_network
set_network 0 ssid "<SSID>"
set_network 0 psk "<PSK>"
```


