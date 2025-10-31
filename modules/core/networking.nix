{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bluez
    bluetui
    impala
  ];

  networking.networkmanager = {
    enable = true;
    wifi = {
      backend = "iwd";
      powersave = false;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        AutoEnable = true;
      };
    };
  };
}
