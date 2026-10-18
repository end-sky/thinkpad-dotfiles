{ config, lib, pkgs, ... }:

{
  # --- Firmware / drivers ---
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;            # Lenovo ships BIOS/firmware updates via LVFS
  services.fstrim.enable = true;           # SSD/NVMe trim

  # --- Power management ---
  services.upower.enable = true;
  services.thermald.enable = true;         # Intel CPUs; harmless no-op on AMD
  services.power-profiles-daemon.enable = false;  # conflicts with TLP
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      # Protect the battery (ThinkPad-specific thresholds; ignored if unsupported)
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Lid / power button behaviour
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandlePowerKey = "suspend";
  };

  # --- Input: touchpad, TrackPoint, touchscreen ---
  services.libinput = {
    enable = true;   # handles touchscreen too
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      disableWhileTyping = true;
      middleEmulation = true;
      clickMethod = "clickfinger";
    };
  };
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };

  # Touchscreen extras: auto-rotation sensors (2-in-1 / Yoga models) and
  # multi-touch gestures
  hardware.sensor.iio.enable = true;
  services.touchegg.enable = true;

  # --- Misc laptop bits ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    brightnessctl     # backlight keys in Qtile
    playerctl
    acpi
    libinput
    xinput
    powertop
  ];
}
