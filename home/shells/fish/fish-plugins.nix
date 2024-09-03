{pkgs, ...}:
let
  sources = import ./sources.nix {inherit pkgs;};
  mkDefault = name: {
    inherit name;
    src = sources.${name};
  };
in
{
  "default-theme" = mkDefault "default-theme";
  "chain-theme" = mkDefault "chain-theme";
  "vcs" = mkDefault "vcs";
  "oh-my-fish" = mkDefault "oh-my-fish";
}
