{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  just,
  libcosmicAppHook,
  libinput,
  openssl,
  udev,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-initial-setup";
  version = "epoch-1.0.0-beta.1.1-unstable-2025-09-30";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-initial-setup";
    rev = "9bf7949fb18b2da574072a562fa51c1dfd42167a";
    hash = "sha256-QYlDPuHCTfxtxfbE8qs6CbFcO0VLLrcFalteeLzISDs=";
  };

  cargoHash = "sha256-orwK9gcFXK4/+sfwRubcz0PP6YAFqsENRHnlSLttLxM=";

  # cargo-auditable fails during the build when compiling the `crabtime::function`
  # procedural macro. It panics because the `--out-dir` flag is not passed to
  # the rustc wrapper.
  auditable = false;

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];

  buildInputs = [
    libinput
    openssl
    udev
  ];

  postPatch = ''
    # Installs in $out/etc/xdg/autostart instead of /etc/xdg/autostart
    substituteInPlace justfile \
      --replace-fail \
      "autostart-dst := rootdir / 'etc' / 'xdg' / 'autostart' / desktop-entry" \
      "autostart-dst := prefix / 'etc' / 'xdg' / 'autostart' / desktop-entry"
  '';

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

  env.DISABLE_IF_EXISTS = "/iso/nix-store.squashfs";

  meta = {
    description = "COSMIC Initial Setup";
    homepage = "https://github.com/pop-os/cosmic-initial-setup";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-initial-setup";
    platforms = lib.platforms.linux;
  };
})
