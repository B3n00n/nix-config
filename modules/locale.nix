{ config, lib, ... }:

let
  vars = config.system.variables;

  lcCategories = [
    "ADDRESS" "IDENTIFICATION" "MEASUREMENT" "MONETARY"
    "NAME" "NUMERIC" "PAPER" "TELEPHONE" "TIME"
  ];
in
{
  time.timeZone = vars.timezone;

  i18n = {
    defaultLocale = vars.locale;
    extraLocaleSettings = lib.genAttrs (map (c: "LC_${c}") lcCategories) (_: vars.locale);
  };
}
