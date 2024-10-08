{pkgs, ...}:
let
  shell_info_addition = ''
    set -l nix_shell_info (if test -n "$IN_NIX_SHELL"; builtin set_color yellow; echo -n "<nix-shell>-"; builtin set_color normal; end)
  '';
in
{
  "oh-my-fish" = pkgs.stdenv.mkDerivation {
     name = "oh-my-fish";
     src = pkgs.fetchFromGitHub {
       owner = "oh-my-fish";
       repo = "oh-my-fish";
       rev = "d427501b2c3003599bc09502e9d9535b5317c677";
       hash = "sha256-dwaA1bJiYcjpWQa4+5R79RohcmKngOHEe7plZt2spr0=";
     };
     buildPhase = ''
       mkdir -p $out/conf.d
       mkdir -p $out/functions
       cp ./lib/git/* $out/functions/
       cp ./lib/*.fish $out/functions/
     '';
  };
  "default-theme" = pkgs.fetchFromGitHub {
      owner = "oh-my-fish";
      repo = "theme-default";
      rev = "38a404d533f49c402f4a9212319ce70395d740d8";
      hash = "sha256-FVZhJo6BTz5Gt7RSOnXXU0Btxejg/p89AhZOvB9Xk1k=";
    };
  "vcs" = pkgs.fetchFromGitHub {
    owner = "oh-my-fish";
    repo = "plugin-vcs";
    rev = "1ddd58fcd046eb29422c7287306530f0b7a7c00b";
    hash = "sha256-BVQgQOnPcqIf4eqLrmuUCvZahyEDKzBgJUeppLQWjQY=";
  };
  "direnv" = pkgs.fetchFromGitHub {
    owner = "oh-my-fish";
    repo = "plugin-direnv";
    rev = "0221a4d9080b5f492f1b56ff7b2dc6287f58d47f";
    hash = "sha256-50tMKwtXtJBpgZ42JfJKyIWgusu4xZ9/yCiGKDfqyhE=";
  };
  "chain-theme" = pkgs.stdenv.mkDerivation {
      name = "chain-theme";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "theme-chain";
        rev = "1cffea20b15bbcd11e578cd88dca097cc2ca23f4";
        hash = "sha256-9czP3f634SXifCdFK9tGcuFG/Z7/+58BxxAD4FzPrz0=";
      };
      buildPhase = ''
        mkdir -p $out
        cp -r * $out
        sed -i '31i \
          if test -n "$IN_NIX_SHELL"; builtin set_color yellow; echo -n "<nix-shell>-"; builtin set_color normal; end \
        ' $out/functions/fish_prompt.fish
      '';
  };
}
