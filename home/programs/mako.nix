# Mako Notification Daemon
{ pkgs, theme, ... }:

{
  services.mako = {
    enable = true;

    # Modern settings format (using settings attribute)
    settings = {
      # Font configuration
      font = "${theme.fonts.sansSerif} ${toString theme.fonts.size.normal}";

      # Color scheme from theme
      background-color = theme.colors.surface0;
      text-color = theme.colors.foreground;
      border-color = theme.colors.primary;
      progress-color = "over ${theme.colors.green}";

      # Border and padding
      border-size = 2;
      border-radius = theme.border.radius;
      padding = "12";
      margin = "10";

      # Icon configuration
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
      max-icon-size = 48;

      # Notification behavior
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;

      # Position
      anchor = "top-right";
      width = 400;
      height = 150;
    };

    # Urgency-specific styling
    extraConfig = ''
      [urgency=low]
      border-color=${theme.colors.blue}
      default-timeout=3000

      [urgency=normal]
      border-color=${theme.colors.primary}
      default-timeout=5000

      [urgency=high]
      border-color=${theme.colors.red}
      default-timeout=0
      
      [app-name="Spotify"]
      border-color=${theme.colors.green}
      default-timeout=3000
    '';
  };
}
