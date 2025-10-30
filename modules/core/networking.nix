{
  networking.networkmanager = {
    enable = true;
    # TODO: resolve if needed or not
    # wifi.backend = "iwd";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
