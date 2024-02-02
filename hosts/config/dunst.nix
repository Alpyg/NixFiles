{ ... }:

{
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      frame_color = "#89b4fa";
      separator_color= "frame";
      origin = "top-right";
      offset = "30x30";
      timeout = "10";
    };
    urgency_low = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
    };
    urgency_normal = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
    };
    urgency_critical = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      frame_color = "#fab387";
    };
  };
}
