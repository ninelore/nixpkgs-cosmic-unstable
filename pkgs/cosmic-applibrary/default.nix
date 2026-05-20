{
  lib,
  fetchFromGitHub,
  stdenv,
  rustPlatform,
  libcosmicAppHook,
  just,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-applibrary";
  version = "0-unstable-2026-05-19";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "df2b050eaed0835c41fdfcf61479cd830f41bd7d";
    hash = "sha256-ixnRJrGnhBUJnXHOyPhGHqd34KmcpSPhslZEC2C7OTs=";
  };

  cargoHash = "sha256-HvsSK6HO2xQzpdHvUZgkv5cTZsim0ST2lslD+D7qjVs=";

  nativeBuildInputs = [
    just
    libcosmicAppHook
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "cargo-target-dir"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-applibrary";
    description = "Application Template for the COSMIC Desktop Environment";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-app-library";
  };
})
