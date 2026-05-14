# Wofi launcher.
{ config, ... }:

let
  theme = config.theme;
in

{
  home.file.".config/wofi/config".text = ''
    width=600
    height=400
    location=center
    show=drun
    prompt=Search...
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=true
    allow_images=true
    image_size=32
    gtk_dark=true
  '';

  home.file.".config/wofi/style.css".text = ''
    * {
        font-family: "${theme.fonts.monospace}", monospace;
        font-size: 14px;
        font-weight: bold;
    }

    window {
        margin: 0px;
        border: ${toString theme.border.width}px solid ${theme.colors.primary};
        background-color: ${theme.colors.background};
        border-radius: 0px;
    }

    #input {
        margin: 8px;
        padding: 8px 12px;
        border: 1px solid ${theme.colors.primary};
        color: ${theme.colors.foreground};
        background-color: ${theme.colors.surface1};
        border-radius: 0px;
    }

    #input:focus {
        border: 1px solid ${theme.colors.green};
        outline: none;
    }

    #inner-box {
        margin: 8px;
        border: none;
        background-color: ${theme.colors.background};
    }

    #outer-box {
        margin: 0px;
        border: none;
        background-color: ${theme.colors.background};
    }

    #scroll {
        margin: 0px;
        border: none;
    }

    #text {
        margin: 4px;
        padding: 4px;
        color: ${theme.colors.foreground};
    }

    #text:selected {
        color: ${theme.colors.background};
    }

    #entry {
        margin: 2px;
        padding: 8px;
        border: 1px solid transparent;
        background-color: transparent;
    }

    #entry:selected {
        border: 1px solid ${theme.colors.primary};
        background-color: ${theme.colors.primary};
        color: ${theme.colors.background};
    }

    #entry:hover {
        background-color: ${theme.hexToRgba theme.colors.primary "0.2"};
    }

    #img {
        margin-right: 8px;
    }
  '';
}
