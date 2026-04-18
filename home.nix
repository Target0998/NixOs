{ config, pkgs, ... }:

{
  home.username = "superonov";
  home.homeDirectory = "/home/superonov";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec start-hyprland
      fi
    '';
  };

  home.file.".config" = {
    source = ./config;
    recursive = true;
  };

  home.file.".vimrc".source = ./config/vim/.vimrc;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
