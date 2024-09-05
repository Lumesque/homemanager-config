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
  };

  outputs = { self, nixpkgs , homeManager, neovim, rust-overlay, zig-overlay, ...}@inputs:
  let
    system = "x86_64-linux";
    overlays = [ (import rust-overlay) zig-overlay.overlays.default ];
    pkgs = import nixpkgs {inherit system overlays;};
    dev-tmux = pkgs.writeShellScriptBin "dev-tmux" ''
     ${builtins.readFile ./scripts/tmux_startup.sh}
    '';
    c-qwert = pkgs.writeShellScriptBin "c-qwert" ''
      ${builtins.readFile ./scripts/qwert_to_dvorak.sh}
    '';
    c-dvorak = pkgs.writeShellScriptBin "c-dvorak" ''
      ${builtins.readFile ./scripts/dvorak_to_qwert.sh}
    '';
    build-source-command = pkgs.writeShellScriptBin "home-build-source" ''
      cd ~/.config/home-manager
      nix build '.#homeConfigurations."lumesque".activationPackage' && ./result/activate
    '';
    build-command = pkgs.writeShellScriptBin "home-build" ''
      cd ~/.config/home-manager
      nix build '.#homeConfigurations."lumesque".activationPackage'
    '';
    home-update-build = pkgs.writeShellScriptBin "home-update-source" ''
      cd ~/.config/home-manager
      nix flake update && home-build-source
    '';
    neovim-package = neovim.packages.${system}.default;
    python-packages = (pkgs.python312.withPackages (pp: [
      pp.ipython
    ]));
    system-pkgs = [
      pkgs.jq
      pkgs.fzf
      pkgs.ripgrep
      pkgs.zigpkgs."0.13.0"
      pkgs.rust-bin.beta."2024-08-05".default
      pkgs.direnv
      pkgs.xorg.xkbcomp
    ];
    list-of-pkgs = [
      neovim-package
      build-command
      build-source-command
      c-qwert
      c-dvorak
      dev-tmux
      home-update-build
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
        modules = [ ./home ];
      };
    };
  };
}
