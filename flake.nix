{
	description = "Lepus portable Nixos";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
		};
	
	};
	outputs = { nixpkgs, home-manager, ... }: {
		nixosConfigurations.nixLepus = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
					useGlobalPkgs = true;
					useUserPackages = true;
					users.superonov = import ./home.nix;
					backupFileExtension = "backup";				
	
					};
				}
			];
		};
	};

}
