{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    theme = "Treehouse";
    keybindings = {
      "cmd+c" = "copy_from_clipboard";
      "cmd+v" = "paste_from_clipboard";
      "shift+insert" = "paste_from_clipboard";
    };
    settings = {
      "enable_audio_bell" = "no";
      "rememeber_window_size" = "yes";
      "font_family" = "Terminess Nerd Font";
    };
  };
}
