{ config, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.stateVersion = "26.05";

  imports = [
    ./alacritty.nix
  ];

  # User packages
  home.packages = with pkgs; [
    bat
    eza
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "eza -lah";
    };
	initExtra = ''
	export PS1='\[\e[96m\]\u@\w ➤ \[\e[0m\]'
	pfetch
	'';
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
