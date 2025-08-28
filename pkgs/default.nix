{ inputs, system, ... }:
with import inputs.nixpkgs {
  inherit system;
  config.allowUnfree = true;
};
{
  cosmic-applets = callPackage ./cosmic-applets { };
  cosmic-applibrary = callPackage ./cosmic-applibrary { };
  cosmic-bg = callPackage ./cosmic-bg { };
  cosmic-comp = callPackage ./cosmic-comp { };
  cosmic-edit = callPackage ./cosmic-edit { };
  cosmic-ext-calculator = callPackage ./cosmic-ext-calculator { };
  cosmic-ext-ctl = callPackage ./cosmic-ext-ctl { };
  cosmic-ext-tweaks = callPackage ./cosmic-ext-tweaks { };
  cosmic-files = callPackage ./cosmic-files { };
  cosmic-greeter = callPackage ./cosmic-greeter { };
  cosmic-icons = callPackage ./cosmic-icons { };
  cosmic-idle = callPackage ./cosmic-idle { };
  cosmic-launcher = callPackage ./cosmic-launcher { };
  cosmic-notifications = callPackage ./cosmic-notifications { };
  cosmic-osd = callPackage ./cosmic-osd { };
  cosmic-panel = callPackage ./cosmic-panel { };
  cosmic-player = callPackage ./cosmic-player { };
  cosmic-protocols = callPackage ./cosmic-protocols { };
  cosmic-randr = callPackage ./cosmic-randr { };
  cosmic-screenshot = callPackage ./cosmic-screenshot { };
  cosmic-session = callPackage ./cosmic-session { };
  cosmic-settings = callPackage ./cosmic-settings { };
  cosmic-settings-daemon = callPackage ./cosmic-settings-daemon { };
  cosmic-store = callPackage ./cosmic-store { };
  cosmic-term = callPackage ./cosmic-term { };
  cosmic-wallpapers = callPackage ./cosmic-wallpapers { };
  cosmic-workspaces-epoch = callPackage ./cosmic-workspaces-epoch { };
}
