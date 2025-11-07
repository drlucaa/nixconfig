{ config, ... }:
{
  config.modules.programs.spotify.enable = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = false; # set true only if you need Steam/Wine
    extraPackages = with pkgs; [
      mesa-vulkan-drivers   # includes lavapipe (software Vulkan) fallback
      vulkan-loader
      vulkan-tools          # optional: gives you `vulkaninfo`
    ];
  };
}
