{ config, pkgs, ... }:

{
   services.xserver = {
   enable = true;
   windowManager.qtile.enable = true;
   displayManager.sessionCommands = ''
        xwallpaper --stretch ~/Pictures/Wallpapers/Wallpaper.png
   '';
  };

  # Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  # Display manager
  services.xserver.displayManager.lightdm.enable = true;

  # USB Stuff
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable basic desktop services
  services.dbus.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
}
