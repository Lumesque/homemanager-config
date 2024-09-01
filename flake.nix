{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:Lumesque/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs , homeManager, neovim, ...}@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    build-command = pkgs.writeShellScriptBin "home-build-source" ''
      cd ~/.config/home-manager
      nix build '.#homeConfigurations."lumesque".activationPackage'
      ./result/activate
    '';
    neovim-package = neovim.packages.${system}.default;
  in
  {
    packages.${system}.default = homeManager.packages.${system}.default;
    homeConfigurations = {
      "lumesque" = homeManager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs pkgs build-command neovim-package;
        };
        modules = [ ./home.nix ];
      };
    };
  };
}
