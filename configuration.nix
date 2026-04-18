{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixLepus";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Budapest";
  services.libinput.enable = true;
  services.getty.autologinUser = "superonov";

  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
  };

  users.users.superonov = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     packages = with pkgs; [
       tree
     ];
   };

  environment.systemPackages = with pkgs; [
     vim
     wget
     vlc
     brave
     git
     kitty
     foot
     waybar
     hyprpaper
   ];


 nix.settings.experimental-features = [ "nix-command" "flakes"];
 system.stateVersion = "25.11"; # Did you read the comment?

}

