{pkgs, build-command, neovim-package, ...}: {
  home = {
    username = "lumesque";
    homeDirectory = "/home/lumesque";
    packages = [
      (pkgs.python312.withPackages (pp: [
        pp.ipython
      ]))
      build-command
      neovim-package
    ];
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
