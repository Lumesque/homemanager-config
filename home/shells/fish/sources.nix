{pkgs, ...}:
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
  "chain-theme" = pkgs.fetchFromGitHub {
    owner = "oh-my-fish";
    repo = "theme-chain";
    rev = "1cffea20b15bbcd11e578cd88dca097cc2ca23f4";
    hash = "sha256-9czP3f634SXifCdFK9tGcuFG/Z7/+58BxxAD4FzPrz0=";
  };
}
