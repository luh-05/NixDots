{ inputs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      #background_opacity = "0.9";
      #background_blur = 0;
      cursor_trail = 1;
      allow_lignatures = true;
      font_size = 10;
    };
  };
}
