{ pkgs, ... }:
{
  system = {
    startup.chime = false;
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        tilesize = 48;
        persistent-apps = [
          "/System/Applications/Mail.app"
          "/Applications/Arc.app"
          "/System/Applications/System Settings.app"
          "${pkgs.ghostty-bin}/Applications/Ghostty.app"
          "/Applications/Spotify.app"
        ];
        expose-group-apps = true;
        show-recents = false;
      };

      finder.FXPreferredViewStyle = "Nlsv";

      NSGlobalDomain = {
        "com.apple.keyboard.fnState" = true;
        AppleFontSmoothing = 0;
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        AppleTemperatureUnit = "Celsius";
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSTableViewDefaultSizeMode = 1;
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowSeconds = true;
        ShowDate = 0;
        ShowDayOfWeek = true;
      };

      controlcenter = {
        BatteryShowPercentage = true;
        AirDrop = false;
        Bluetooth = false;
        Display = false;
        FocusModes = false;
        NowPlaying = false;
        Sound = true;
      };

      loginwindow.GuestEnabled = false;

      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            "64" = {
              enabled = false;
            };
          };
        };
      };
    };
  };
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;
  };
}
