{ config, pkgs, ... }:

{
  imports = [
    ./programs.nix
    ./packages.nix
    ./thinkpad.nix
  ];

  # Bootloader
  # ThinkPads boot via UEFI (NVMe/SSD), so systemd-boot replaces the old
  # BIOS-style GRUB on /dev/sda. If you dual-boot and want os-prober, switch
  # back to GRUB with efiSupport = true and device = "nodev".
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  # Networking
  networking.networkmanager.enable = true;
  services.mullvad-vpn.enable = true;

  # Time zone
  time.timeZone = "America/Sao_Paulo";

  # Locale
  i18n.defaultLocale = "pt_BR.UTF-8";

  # X11
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };
  console.keyMap = "br-abnt2";

  # Your user
  users.users.user = {
    isNormalUser = true;
    description = "lynn";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
  };

  # Allow sudo for wheel
  security.sudo.wheelNeedsPassword = true;
  nixpkgs.config.allowUnfree = true;

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

services.picom = {
   enable = true;
   backend = "glx";
   fade = true;
};

  system.stateVersion = "26.05";
}
