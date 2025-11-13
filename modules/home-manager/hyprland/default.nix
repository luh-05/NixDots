{ inputs, pkgs, lib, config, ... }:

#let
#  hyprlandConfigLocation = ./;
#  cLoc = hyprlandConfigLocation;
#in
let
  base0FColor = config.stylix.base16Scheme.base0F;
in
{
  #imports = 
  #  [
  #    "${cLoc}/hyprland/general.nix" 
  #  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    systemd.variables = ["--all"];
    extraConfig = 
    ''
      submap = insert
      bind = , Return, exec, wtype -m alt -P insert
      bind = , Return, submap, reset
      submap = reset
    '';
    settings = { 
      debug.disable_logs = "false";
      # set up environment variables
      env = 
        [
          "DISPLAY"
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];

      # set up keyboard and mouse
      input = {
        kb_layout = "us";
        accel_profile = "flat";
        ## set up cursor
      };
      cursor = {
        no_hardware_cursors = "true";
      };

      misc = {
        #disable_hyprland_logo = "true";
      };

      experimental = {
        xx_color_management_v4 = "true";
      };

      exec-once = 
        [
          "sleep 5 ; swww-daemon"
          #"swww img ${pkgs.stylix.image}"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];

      # set up monitors
      "$mon2" = "DP-4";
      "$mon0" = "DP-2";
      "$mon1" = "DP-3";
      "$tab" = "HDMI-A-2";
      monitor =
        [
          "$mon2, 3440x1440@165, 0x1080, 1, bitdepth, 10"
          "$mon0, 1920x1080@144, 0x0, 1"
          "$mon1, 1920x1080@60, 1920x0, 1"
          "$tab, 1920x1080@60, 3840x0, 1"
        ];
      # assign workspaces 1-5 to $mon0 and 6-10 to $mon1
      workspace = (
        builtins.concatLists (
          builtins.genList (
            x:
            let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in 
              [
                #"${if ws == 10 then builtins.toString (0) else builtins.toString (ws)}, monitor:${if x < 5 then "$mon0" else "$mon1"}"
                "${ws}, monitor:${if ws == "1" then "$mon0" else if ws == "9" then "$mon1" else "$mon2"}"
                #${ws}, monitor:$mon2"
              ]
          )
          10)
        );

      group = {
        # FIXME
        # "col.active" = lib.mkForce "rgba(D1AF6CFF)";
        # "col.inactive" = lib.mkForce "rgba(212121FF)";
        groupbar = {
          height = 1;
          font_size = 12;
          text_offset = -12;
          indicator_height = 24;
          rounding = 10;
          "col.active" = lib.mkForce "rgba(5B74B1FF)";
          "col.inactive" = lib.mkForce "rgba(525252FF)";
        };
      };

      # set up bindings
      "$mod" = "SUPER";
      "$term" = "kitty -o allow_remote_control=yes --listen-on unix:/tmp/kitty_remote_control";
      "$browser" = "floorp";
      "$explorer" = "dolphin";
      #"$menu" = "killall .wofi-wrapped & wofi --show drun";
      "$menu" = "killall wofi || wofi --show drun";
      # "$fsm" = "bash ~/.config/eww/dashboard/launch_dashboard";
      bind =
        [
          # hyprland controls
          "$mod SHIFT, m, exit"
          "$mod SHIFT, r, exec, hyprctl reload; notify-send \"Hyprland Reloaded!\""
          
          # window controls
          "$mod, q, killactive"
          "$mod, f, fullscreen, 0"
          "$mod, d, fullscreen, 1"
          "$mod, v, togglefloating"
          "$mod, Minus, splitratio, -0.1"
          "$mod, Comma, splitratio, -0.1"
          "$mod, Plus, splitratio, +0.1"
          "$mod, Colon, splitratio, +0.1"

          # movement
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod, i, togglesplit"

          # app bindings
          "$mod, return, exec, $term"
          # "$mod, b, exec, $browser"
          "$mod, e, exec, $explorer"
          "$mod, space, exec, $menu"
          # "$mod SHIFT, space, exec, $fsm"

          # utils
          # "$mod SHIFT, s, exec, XDG_CURRENT_DESKTOP=sway flameshot gui"
          # "$mod SHIFT ALT, s, exec, grimblast --notify --freeze copysave screen"
          "$mod SHIFT, s, exec, grimblast --notify --freeze copysave area"
          "$mod SHIFT ALT, s, exec, grimblast --notify --freeze copysave screen"

          # workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          
          # scratchpad
          "$mod, y, togglespecialworkspace, magic"
          "$mod SHIFT, y, movetoworkspace, special:magic"

          # german sybols
          "$mod, a, exec, wtype 'ä'"
          "$mod, o, exec, wtype 'ö'"
          "$mod, u, exec, wtype 'ü'"
          "$mod, s, exec, wtype 'ß'"
          "$mod SHIFT, a, exec, wtype 'Ä'"
          "$mod SHIFT, o, exec, wtype 'Ö'"
          "$mod SHIFT, u, exec, wtype 'Ü'"

          # groups
          "$mod, g, togglegroup"
          "$mod, c, changegroupactive"
          "$mod, b, lockactivegroup"

          # hyprpanel
          "$mod SHIFT, space, exec, hyprpanel t bar-2"

          # special keys
          #"$mod, i, submap, insert"
        ]
        ++ (
          # workspaces
          # binds $mod + 1..10 to switching workspaces
          # also binds $mod + SHIFT + 1..10 to moving windows to workspaces
          builtins.concatLists (
            builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
          10)
      );
      # submaps
      #submap = {
      #  insert = {
      #    ", Return" = [
      #      "exec, wtype -k insert -k return"
      #      "submap, reset"
      #    ]; 
      #  };
      #};

      # media controls
      bindl =
        [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          "$mod, down, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          "$mod, up, exec, playerctl play-pause"
          "$mod, right, exec, playerctl next"
          "$mod, left, exec, playerctl previous"
        ];
      bindle =
        [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          "SHIFT, XF86AudioRaiseVolume, exec, playerctl volume 0.05+"
          "SHIFT, XF86AudioLowerVolume, exec, playerctl volume 0.05-"
          "$mod, home, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          "$mod, delete, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
          "$mod SHIFT, home, exec, playerctl volume 0.05+"
          "$mod SHIFT, delete, exec, playerctl volume 0.05-"
        ];


      bindm =
        [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

      general = {
        # gaps and borders
        gaps_in = "4";
        gaps_out = "5";
        gaps_workspaces = "50";
        border_size = "1";

        # fallback colors
        #"col.active_border" = lib.mkForce "rgb(${toString base0FColor})";
        "col.active_border" = lib.mkForce "rgba(525252FF)";
        "col.inactive_border" = lib.mkForce "rgba(0000002A)";

        resize_on_border = "true";
        no_focus_fallback = "true";
        layout = "dwindle";

        allow_tearing = "true"; # allows the 'immediate' window rule
      };

      dwindle = {
        preserve_split = "true";
        smart_split = "false";
        smart_resizing = "false";
      };

      bezier = [
        "funk,0.32,1.06,0.0,0.99"
      ];

      animation = [
        "workspaces,1,7,funk,slidefade 0%"
        "windows,1,7,funk,slide"
        "fade,1,7,funk"
        "border,1,2,funk"
        "borderangle,1,2,funk"
        "layersIn,1,7,funk,slide top"
        "layersOut,1,7,funk,slide bottom"
      ];

      decoration = {
        rounding = "15";

        blur = {
          enabled = "true";
          xray = "true";
          special = "false";
          new_optimizations = "true";
          size = "2";
          passes = "2";
          brightness = "1";
          noise = "0.01";
          contrast = "1";
          popups = "true";
          popups_ignorealpha = "0.6";
        };

        # shadow-options
        shadow = {
          enabled = "true";
          ignore_window = "true";
          range = "20";
          offset = "0 2";
          render_power = "4";
          color = lib.mkForce"rgba(0000002A)";
        }; 
        "col.shadow" = lib.mkOverride 0 (
          builtins.removeAttrs {} ["col.shadow"]
        );

        #drop_shadow = "true";
        #shadow_ignore_window = "true";
        #shadow_range = "20";
        #shadow_offset = "0 2";
        #shadow_render_power = "4";
        #"col.shadow" = lib.mkForce"rgba(0000002A)";

        # Dimming
        dim_inactive = "true";
        dim_strength = "0.1";
        dim_special = "0";
      };

      windowrulev2 = 
        [
          #"float,class:^(cyberpunk2077.exe)$"
          #"size 75% 75%,class:^(cyberpunk2077.exe)$"
          "move 0 0,class:(flameshot),title:(flameshot)"
          "pin,class:(flameshot),title:(flameshot)"
          "fullscreen,class:(flameshot),title:(flameshot)"
          "float,class:(flameshot),title:(flameshot)"
          "noanim, class:hyprpanel"
        ];
    };
  };
}
