{config, pkgs, ...}:

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
			if [ -z "$WAYLAND_DISPLAY"] && [ "$XDG_VTNR"] = 1 ]; then
				exec start-hyprland
			fi
		'';
		
	};
	home.file.".config" = {
  		source = ./config;
  		recursive = true;
	};


}
