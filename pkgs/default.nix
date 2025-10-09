inputs: final: prev: {
  cosmic-applets = prev.callPackage ./cosmic-applets { };
  cosmic-applibrary = prev.callPackage ./cosmic-applibrary { };
  cosmic-bg = prev.callPackage ./cosmic-bg { };
  cosmic-comp = prev.callPackage ./cosmic-comp { };
  cosmic-ext-applet-caffeine = prev.callPackage ./cosmic-ext-applet-caffeine { };
  cosmic-ext-applet-clipboard-manager = prev.callPackage ./cosmic-ext-applet-clipboard-manager { };
  cosmic-ext-applet-external-monitor-brightness =
    prev.callPackage ./cosmic-ext-applet-external-monitor-brightness
      { };
  cosmic-edit = prev.callPackage ./cosmic-edit { };
  cosmic-ext-calculator = prev.callPackage ./cosmic-ext-calculator { };
  cosmic-ext-ctl = prev.callPackage ./cosmic-ext-ctl { };
  cosmic-ext-tweaks = prev.callPackage ./cosmic-ext-tweaks { };
  cosmic-files = prev.callPackage ./cosmic-files { };
  cosmic-greeter = prev.callPackage ./cosmic-greeter { };
  cosmic-icons = prev.callPackage ./cosmic-icons { };
  cosmic-idle = prev.callPackage ./cosmic-idle { };
  cosmic-initial-setup = prev.callPackage ./cosmic-initial-setup { };
  cosmic-launcher = prev.callPackage ./cosmic-launcher { };
  cosmic-notifications = prev.callPackage ./cosmic-notifications { };
  cosmic-osd = prev.callPackage ./cosmic-osd { };
  cosmic-panel = prev.callPackage ./cosmic-panel { };
  cosmic-player = prev.callPackage ./cosmic-player { };
  cosmic-protocols = prev.callPackage ./cosmic-protocols { };
  cosmic-randr = prev.callPackage ./cosmic-randr { };
  cosmic-screenshot = prev.callPackage ./cosmic-screenshot { };
  cosmic-session = prev.callPackage ./cosmic-session { };
  cosmic-settings = prev.callPackage ./cosmic-settings { };
  cosmic-settings-daemon = prev.callPackage ./cosmic-settings-daemon { };
  cosmic-store = prev.callPackage ./cosmic-store { };
  cosmic-term = prev.callPackage ./cosmic-term { };
  cosmic-wallpapers = prev.callPackage ./cosmic-wallpapers { };
  cosmic-workspaces-epoch = prev.callPackage ./cosmic-workspaces-epoch { };
  xdg-desktop-portal-cosmic = prev.callPackage ./xdg-desktop-portal-cosmic { };

  # Build for cache
  cosmic-manager = prev.callPackage "${inputs.cosmic-manager}/cosmic-manager" { };
}
