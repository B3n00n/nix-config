# Locale and time zone configuration
{ config, ... }:

{
  # Time zone from centralized variables
  time.timeZone = config.system.variables.timezone;

  # Internationalization settings
  i18n = {
    # Default system locale from centralized variables
    defaultLocale = config.system.variables.locale;

    # Additional locale settings for specific categories
    extraLocaleSettings = {
      LC_ADDRESS = config.system.variables.locale;
      LC_IDENTIFICATION = config.system.variables.locale;
      LC_MEASUREMENT = config.system.variables.locale;
      LC_MONETARY = config.system.variables.locale;
      LC_NAME = config.system.variables.locale;
      LC_NUMERIC = config.system.variables.locale;
      LC_PAPER = config.system.variables.locale;
      LC_TELEPHONE = config.system.variables.locale;
      LC_TIME = config.system.variables.locale;
    };
  };
}
