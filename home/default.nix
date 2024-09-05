{list-of-pkgs, ...}: {
  imports = [
    ./shells/fish
    ./tmux
  ];
  home = {
    username = "lumesque";
    homeDirectory = "/home/lumesque";
    packages = list-of-pkgs;
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
