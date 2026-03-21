# nix-ld — dynamic linker + common libraries for precompiled binaries
{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Display servers
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXi
      xorg.libXext
      xorg.libXfixes
      wayland
      libxkbcommon
      libdecor

      # Graphics / GPU
      libGL
      vulkan-loader

      # Audio
      alsa-lib
      libpulseaudio

      # Common runtime deps
      stdenv.cc.cc.lib   # libstdc++
      zlib
      icu
      openssl
      curl
      dbus
      fontconfig
      freetype
    ];
  };
}
