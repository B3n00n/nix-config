{ config, lib, ... }:

let
  vars = config.system.variables;

  # MIME types Neovim should own by default. Used for both the mimeApps
  # mapping and the .desktop MimeType field.
  nvimMimeTypes = [
    "text/plain"
    "text/x-log"
    "application/x-shellscript"
  ];

  mpvMimeTypes = [
    "audio/mpeg"
    "audio/wav"
    "audio/x-wav"
    "audio/flac"
    "audio/ogg"
    "audio/mp4"
    "audio/aac"
    "audio/opus"
    "audio/webm"
    "video/mp4"
    "video/x-matroska"
    "video/webm"
    "video/quicktime"
    "video/x-msvideo"
  ];
in
{
  # Thunar's "Open Terminal Here" reads this.
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${vars.apps.terminal}
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      lib.genAttrs nvimMimeTypes (_: [ "nvim.desktop" ])
      // lib.genAttrs mpvMimeTypes (_: [ "mpv.desktop" ]);
  };

  # Custom launcher so GUI "Open With → Neovim" gets a usable editor.
  xdg.dataFile."applications/nvim.desktop".text = ''
    [Desktop Entry]
    Name=Neovim
    GenericName=Text Editor
    Comment=Edit text files
    Exec=${vars.apps.terminal} nvim %F
    Terminal=false
    Type=Application
    Icon=nvim
    Categories=Utility;TextEditor;
    MimeType=${lib.concatStringsSep ";" nvimMimeTypes};
  '';
}
