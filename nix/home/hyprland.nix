{pkgs, ...}:
{
  enable = true;
  settings = {
    "$mod" = "SUPER";
    bind =
    [
      "$mod, Q, exec, alacritty"
      "$mod, C, killactive"
      "$mod, M, exit"
      "$mod, F, exec, firefox"
      "$mod, E, exec, nautilus"
      "$mod, V, togglefloating"
      "$mod, R, exec, wofi --show drun"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"
      "$mod, T, togglegroup"
      "$mod+ALT, J, changegroupactive, f"
      "$mod+ALT, K, changegroupactive, f"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString(x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]
      )
      10)
    );
  };

  extraConfig = ''
  exec-once = ags

  bezier=easeOutBack,0.34,1.56,0.64,1
  bezier=easeInBack,0.36,0,0.66,-0.56
  bezier=easeInCubic,0.32,0,0.67,0
  bezier=easeInOutCubic,0.65,0,0.35,1
  animation=windowsIn,1,5,easeOutBack,popin
  animation=windowsOut,1,5,easeInBack,popin
  animation=fadeIn,0
  animation=fadeOut,1,10,easeInCubic
  animation=workspaces,1,4,easeInOutCubic,slide
  general:gaps_out=30
  xwayland {
    force_zero_scaling = true
  }

  input {
    follow_mouse = 1
      touchpad {
        natural_scroll = true
          disable_while_typing = true
          tap-to-click = false
          middle_button_emulation = false
      }
    sensitivity = 0
  }
  '';
}
