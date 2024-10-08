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
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs , homeManager, neovim, rust-overlay, zig-overlay, zen-browser, nixgl, ...}@inputs:
  let
    system = "x86_64-linux";
    overlays = [ (import rust-overlay) zig-overlay.overlays.default nixgl.overlay ];
    pkgs = import nixpkgs {inherit system overlays;};
    neovim-package = neovim.packages.${system}.default;
    python-packages = (pkgs.python312.withPackages (pp: [
      pp.ipython
    ]));
    browser-package = zen-browser.packages.${system}.default;
    bin-packages = import ./bin.nix {inherit pkgs;};
    system-pkgs = [
      pkgs.jq
      pkgs.fzf
      pkgs.ripgrep
      pkgs.zigpkgs."0.13.0"
      pkgs.rust-bin.beta."2024-08-05".default
      pkgs.direnv
      pkgs.xorg.xkbcomp
      pkgs.vesktop
        # This requres impure
        #pkgs.nixgl.auto.nixGLDefault
    ];
    list-of-pkgs = [
      neovim-package
      python-packages
      browser-package
    ] ++ system-pkgs ++ (builtins.attrValues bin-packages);
  in
  {
    packages.${system}.default = homeManager.packages.${system}.default;
    homeConfigurations = {
      "lumesque" = homeManager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit list-of-pkgs;
        };
        modules = [ ./home ];
      };
    };
  };
}
