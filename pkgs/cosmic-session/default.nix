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
  version = "epoch-1.2.0-unstable-2026-07-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-session";
    rev = "b5ef6c0c0d68762b2991e4f5906cc70599e2f1fc";
    hash = "sha256-lL8is6WveKxOn/Ej3SrMfLrulnb+Qw9QAPcCbdLo07E=";
  };

  cargoHash = "sha256-5dLG40X+yxJo566guyHqOCLNp+uNSE+HONS8GIDm58A=";

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
