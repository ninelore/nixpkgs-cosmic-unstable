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
  version = "epoch-1.0.0-beta.2-unstable-2025-10-16";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "fec5ffef688c7f5198633c78e7a10a8f641c612a";
    hash = "sha256-hjvkwHhKkCk3sUEHSOxeDUixtG49SkopE1LmFoSqDcM=";
  };

  cargoHash = "sha256-4yRBgFrH4RBpuvChTED+ynx+PyFumoT2Z+R1gXxF4Xc=";

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
    "cargo-target-dir"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}"
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
