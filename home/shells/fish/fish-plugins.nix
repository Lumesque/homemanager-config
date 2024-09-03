{pkgs, ...}:
let
  sources = import ./sources.nix {inherit pkgs;};
  mkDefault = name: {
    inherit name;
    src = sources.${name};
  };
in
  builtins.listToAttrs (
    (builtins.map
      (k: { name = k; value = mkDefault k;})
    ) (builtins.attrNames sources)
  )
