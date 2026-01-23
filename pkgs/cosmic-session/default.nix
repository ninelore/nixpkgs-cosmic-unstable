{
  lib,
  fetchFromGitHub,
  bash,
  rustPlatform,
  just,
  dbus,
  stdenv,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-session";
  version = "epoch-1.0.3-unstable-2026-01-22";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-session";
    rev = "3506cfc404222acab080a0bfd7f28a978eb71372";
    hash = "sha256-l3e708NPx1J8iTKXT5aCuRdORPMCcefpurumasJBK+M=";
  };

  cargoHash = "sha256-wFh9AYQRZB9qK0vCrhW9Zk61Yg+VY3VPAqJRD47NbK4=";

  # TODO: The `systemctl --user import-environment ...` isnt ideal. Watch https://github.com/NixOS/nixpkgs/pull/419493.
  postPatch = ''
    substituteInPlace data/start-cosmic \
      --replace-fail '/usr/bin/cosmic-session' "${placeholder "out"}/bin/cosmic-session" \
      --replace-fail '/usr/bin/dbus-run-session' "${lib.getBin dbus}/bin/dbus-run-session" \
      --replace-fail 'systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP DCONF_PROFILE' '${lib.getExe' dbus "dbus-update-activation-environment"} --systemd PATH XDG_SESSION_CLASS XDG_CONFIG_DIRS XDG_DATA_DIRS XDG_SESSION_DESKTOP XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DCONF_PROFILE XDG_DESKTOP_PORTAL_DIR DISPLAY WAYLAND_DISPLAY XMODIFIERS XCURSOR_SIZE XCURSOR_THEME GDK_PIXBUF_MODULE_FILE GIO_EXTRA_MODULES GTK_IM_MODULE QT_PLUGIN_PATH QT_QPA_PLATFORMTHEME QT_STYLE_OVERRIDE QT_IM_MODULE NIXOS_OZONE_WL &>/dev/null'
    substituteInPlace data/cosmic.desktop \
      --replace-fail '/usr/bin/start-cosmic' "${placeholder "out"}/bin/start-cosmic"
  '';

  buildInputs = [ bash ];
  nativeBuildInputs = [ just ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "cosmic_dconf_profile"
    "${placeholder "out"}/etc/dconf/profile/cosmic"
    "--set"
    "cargo-target-dir"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  passthru.providedSessions = [ "cosmic" ];

  env.ORCA = "orca"; # get orca from $PATH

  meta = {
    homepage = "https://github.com/pop-os/cosmic-session";
    description = "Session manager for the COSMIC desktop environment";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-session";
    platforms = lib.platforms.linux;
  };
})
