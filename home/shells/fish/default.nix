{pkgs, ...}:

let
  plugin-sources = import ./fish-plugins.nix {inherit pkgs;};
in
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "ls -aF --color=always";
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
    plugins = [
      plugin-sources.oh-my-fish
      plugin-sources.default-theme
      plugin-sources.direnv
    ];
    functions = {
      cdf = "cd $(dirname $(fzf))";
      home = "cd ~";
      nf = "nvim $(fzf)";
      up = ''
        set -l this $argv[1]
        set -l result (string match --regex '\D*' $this)
        if not test -z $result;
            echo "Argument provided must be a number" >&2
            return 2
        else if test $this -lt 0;
            echo "Argument provided cannot be less than 0" >&2
            return 1
        end
        cd (string repeat -n $this ../)
      '';
      ggpush = "git push origin $(git branch --show-current)";
    };
  };
}
