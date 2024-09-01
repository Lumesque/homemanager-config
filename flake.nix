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
    build-source-command = pkgs.writeShellScriptBin "home-build-source" ''
      cd ~/.config/home-manager
      nix build '.#homeConfigurations."lumesque".activationPackage' && ./result/activate
    '';
    build-command = pkgs.writeShellScriptBin "home-build" ''
      cd ~/.config/home-manager
      nix build '.#homeConfigurations."lumesque".activationPackage'
    '';
    neovim-package = neovim.packages.${system}.default;
    python-packages = (pkgs.python312.withPackages (pp: [
      pp.ipython
    ]));
    system-pkgs = [
      pkgs.jq
    ];
    list-of-pkgs = [
      neovim-package
      build-command
      build-source-command
      python-packages
    ] ++ system-pkgs;
  in
  {
    packages.${system}.default = homeManager.packages.${system}.default;
    homeConfigurations = {
      "lumesque" = homeManager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit list-of-pkgs;
        };
        modules = [ ./home.nix ];
      };
    };
  };
}
