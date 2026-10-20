{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal
    alacritty

    # Utilities
    git
    xarchiver
    unrar
    pfetch
    mullvad-vpn
    dmenu
    xwallpaper
    shotgun
    keepassxc
    geeqie
    mpv
    tree
    git
    trash-cli

    # Virtualization and Compatability
    wine
    virt-manager
    qemu

    # System tools
    btop
    fastfetch

    # File management
    pcmanfm

    # Editors
    vim
    libreoffice
    gimp

    # Wayland/X11 utilities
    picom

    # Networking
    networkmanagerapplet
 
    # Browser
    librewolf
    tor-browser
    ungoogled-chromium

    # Aesthetic
    cmatrix
    cava
    lxappearance

    # Programming
    vscode
    go
    php
    gcc
    rustc
    cargo
    nodejs
    python3
  ];
}
