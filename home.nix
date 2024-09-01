{pkgs, build-command, ...}: {
  home = {
    username = "lumesque";
    homeDirectory = "/home/lumesque";
    packages = [
      pkgs.cowsay
      pkgs.hello
      build-command
    ];
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
