{
  networking.networkmanager = {
    enable = true;
    wifi = {
      scanRandMacAddress = false;
      macAddress = "permanent";
      powersave = false;
    };
    # TODO: resolve if needed or not
    # wifi.backend = "iwd";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
