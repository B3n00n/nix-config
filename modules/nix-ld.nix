# Common libraries on the dynamic linker for precompiled binaries.
{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libx11 libxcursor libxrandr libxinerama
      libxi libxext libxfixes
      wayland libxkbcommon libdecor

      libGL vulkan-loader

      alsa-lib libpulseaudio

      stdenv.cc.cc.lib
      zlib icu openssl curl dbus fontconfig freetype
    ];
  };
}
