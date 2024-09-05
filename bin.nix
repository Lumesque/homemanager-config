{pkgs, ...}: {
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
}
