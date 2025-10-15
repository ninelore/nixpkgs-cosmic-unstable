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
  version = "epoch-1.0.0-beta.1.1-unstable-2025-10-14";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-initial-setup";
    rev = "0080330b6dacafccebc3aac74f3fccaf20f87f67";
    hash = "sha256-sgtZioUvBDSqlBVWbqGc2iVpZKF0fn/Mr1qo1qlzdlA=";
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
