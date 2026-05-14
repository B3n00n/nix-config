# Dracula — https://draculatheme.com
{
  dark = true;

  fonts = {
    monospace = "Fira Code";
    terminal  = "Fira Code";
  };

  colors = {
    background   = "#282a36";
    foreground   = "#f8f8f2";
    primary      = "#bd93f9";
    primaryLight = "#d6acff";

    red    = "#ff5555";
    yellow = "#f1fa8c";
    green  = "#50fa7b";
    cyan   = "#8be9fd";
    blue   = "#6272a4";        # Dracula has no distinct blue; this is the comment blue.
    purple = "#bd93f9";

    surface0 = "#21222c";
    surface1 = "#44475a";
    surface2 = "#6272a4";

    comment    = "#6272a4";
    lightCyan  = "#8be9fd";
    lightGreen = "#50fa7b";
  };

  # 16-color terminal palette (differs from UI colors for readability).
  terminal = {
    black   = "#21222c";  brightBlack   = "#6272a4";
    red     = "#ff5555";  brightRed     = "#ff6e6e";
    green   = "#50fa7b";  brightGreen   = "#69ff94";
    yellow  = "#f1fa8c";  brightYellow  = "#ffffa5";
    blue    = "#bd93f9";  brightBlue    = "#d6acff";
    magenta = "#ff79c6";  brightMagenta = "#ff92df";
    cyan    = "#8be9fd";  brightCyan    = "#a4ffff";
    white   = "#f8f8f2";  brightWhite   = "#ffffff";
  };

  wallpaper = ../../../assets/wallpapers/dracula.jpg;
}
