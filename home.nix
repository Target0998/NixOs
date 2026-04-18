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
        exec Hyprland
      fi
    '';
  };

  home.file.".config" = {
    source = ./config;
    recursive = true;
  };

  programs.vim = {
    enable = true;
    settings = {
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      mouse = "a";
      history = 1000;
      ignorecase = true;
      smartcase = true;
    };
    extraConfig = ''
      syntax on
      set incsearch
    '';
  };

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IdentityFile ~/.ssh/ed-225519
    '';
  };

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
