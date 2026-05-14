{ ... }:
{
  home.file.".local/bin/screenshot.sh" = {
    source = ./scripts/screenshot.sh;
    executable = true;
  };

  home.file.".local/bin/theme-switcher.sh" = {
    source = ./scripts/theme-switcher.sh;
    executable = true;
  };
}
