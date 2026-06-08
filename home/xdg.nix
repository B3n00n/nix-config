{ config, lib, ... }:

let
  vars = config.system.variables;

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

  pdfApp = "org.pwmt.zathura-pdf-mupdf.desktop";

  officeApps =
    lib.genAttrs [
      "application/msword"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/vnd.oasis.opendocument.text"
      "application/rtf"
    ] (_: [ "writer.desktop" ])
    // lib.genAttrs [
      "application/vnd.ms-excel"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.oasis.opendocument.spreadsheet"
    ] (_: [ "calc.desktop" ])
    // lib.genAttrs [
      "application/vnd.ms-powerpoint"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/vnd.oasis.opendocument.presentation"
    ] (_: [ "impress.desktop" ]);
in
{
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${vars.apps.terminal}
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      lib.genAttrs nvimMimeTypes (_: [ "nvim.desktop" ])
      // lib.genAttrs mpvMimeTypes (_: [ "mpv.desktop" ])
      // officeApps
      // {
        "application/pdf" = [ pdfApp ];
      };
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
