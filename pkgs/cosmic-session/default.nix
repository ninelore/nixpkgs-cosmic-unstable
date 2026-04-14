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
  version = "epoch-1.0.9-unstable-2026-04-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-session";
    rev = "9a55864e81b9e0f3cf31862724b738349402c6de";
    hash = "sha256-t7BUBJ9MjTSd2rSkKtiYkltbfcpOcXl2smXxV84l3GY=";
  };

  cargoHash = "sha256-wFh9AYQRZB9qK0vCrhW9Zk61Yg+VY3VPAqJRD47NbK4=";

  # TODO: The `systemctl --user import-environment ...` isnt ideal. Watch https://github.com/NixOS/nixpkgs/pull/419493.
  postPatch = ''
    substituteInPlace data/start-cosmic \
      --replace-fail '/usr/bin/cosmic-session' "${placeholder "out"}/bin/cosmic-session" \
      --replace-fail '/usr/bin/dbus-run-session' "${lib.getBin dbus}/bin/dbus-run-session"
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
