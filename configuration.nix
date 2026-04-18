{ config, lib, pkgs, ... }:

{
  imports =
    [
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

  security.polkit.enable = true;

  users.users.superonov = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    # Editors
    vim
    neovim

    # Core utilities
    wget
    git
    jq

    # Browser
    brave

    # Terminal emulators
    kitty
    foot

    # Wayland / Hyprland ecosystem
    waybar
    hyprpaper
    hypridle
    hyprlock
    swww
    waypaper
    rofi-wayland
    swaynotificationcenter
    wl-clipboard
    cliphist

    # Screenshots
    grim
    slurp

    # System controls
    brightnessctl
    playerctl

    # Polkit agent
    polkit_gnome

    # Cursor theme
    bibata-cursors

    # Media
    vlc

    # System tools
    fastfetch
    btop
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}
