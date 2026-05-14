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
in
{
  # Thunar's "Open Terminal Here" reads this.
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${vars.apps.terminal}
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.genAttrs nvimMimeTypes (_: [ "nvim.desktop" ]);
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
