{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  cmake,
  just,
  libinput,
  linux-pam,
  udev,
  coreutils,
  xkeyboard_config,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-greeter";
  version = "epoch-1.0.0-alpha.7-unstable-2025-08-12";

  # nixpkgs-update: no auto update
  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "7317353a32f9ed831423819d620775d4bad1db2f";
    hash = "sha256-2MfbtEVTarhsHM3zjX1csHU/nPkxiZLT1F6bmNPrkBI=";
  };

  cargoHash = "sha256-X/tSofi4aNtA5MeWCy03Tnnz3AxIF8MCZ7ofeMSWNCc=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

  cargoBuildFlags = [ "--all" ];

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    cmake
    just
    libcosmicAppHook
  ];

  buildInputs = [
    libinput
    linux-pam
    udev
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-greeter"
    "--set"
    "daemon-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-greeter-daemon"
  ];

  postPatch = ''
    substituteInPlace src/greeter.rs --replace-fail '/usr/bin/env' '${lib.getExe' coreutils "env"}'
  '';

  preFixup = ''
    libcosmicAppWrapperArgs+=(
      --set-default X11_BASE_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/base.xml
      --set-default X11_BASE_EXTRA_RULES_XML ${xkeyboard_config}/share/X11/xkb/rules/extra.xml
    )
  '';

  meta = {
    homepage = "https://github.com/pop-os/cosmic-greeter";
    description = "Greeter for the COSMIC Desktop Environment";
    mainProgram = "cosmic-greeter";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
