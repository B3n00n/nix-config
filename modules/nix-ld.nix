# Common libraries on the dynamic linker for precompiled binaries.
{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      xorg.libX11 xorg.libXcursor xorg.libXrandr xorg.libXinerama
      xorg.libXi xorg.libXext xorg.libXfixes
      wayland libxkbcommon libdecor

      libGL vulkan-loader

      alsa-lib libpulseaudio

      stdenv.cc.cc.lib
      zlib icu openssl curl dbus fontconfig freetype
    ];
  };
}
