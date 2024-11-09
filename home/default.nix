{list-of-pkgs, ...}: {
  imports = [
    ./shells/fish
    ./tmux
    # Currently on non-nix os systems, you need to install nixGL in order for this to work
    # ./terminals/kitty
  ];
  home = {
    username = "lumesque";
    homeDirectory = "/home/lumesque";
    packages = list-of-pkgs;
    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
