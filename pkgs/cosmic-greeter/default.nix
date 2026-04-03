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
  orca,
  cosmic-randr,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-greeter";
  version = "epoch-1.0.8-unstable-2026-04-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "c3e2182c3836cff8edeb34a46125e775e279e2dd";
    hash = "sha256-KG/+XVCGLd8AkQbZ5RtotjjB3337T+l2OKeujvw8uKo=";
  };

  cargoHash = "sha256-+mbw9g6+5sPGtOWN7GFfrbpJ/7WHIz6ATy/8xkrha0U=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;

  cargoBuildFlags = [ "--all" ];

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    cmake
    just
    libcosmicAppHook
  ];

  buildInputs = [
    cosmic-randr
    libinput
    linux-pam
    udev
    orca
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
    substituteInPlace src/greeter.rs --replace-fail '/usr/bin/orca' '${lib.getExe orca}'
  '';

  preFixup = ''
    libcosmicAppWrapperArgs+=(
      --prefix PATH : ${lib.makeBinPath [ cosmic-randr ]}
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
