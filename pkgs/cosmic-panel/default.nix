{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  just,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-panel";
  version = "epoch-1.0.0-alpha.7-unstable-2025-09-03";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-panel";
    rev = "f0e2d217c6cbfb656ffbcfc03be28191ccf42468";
    hash = "sha256-rWfItTECf8XGOWI7B8f7b1fsdEREPwYTVf9FZZRZ4Zo=";
  };

  cargoHash = "sha256-m9tWSJ/77uD29k6FFxLNtyZCkR32LHy5lzCAEPH5uXw=";

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
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-panel"
  ];

  meta = {
    homepage = "https://github.com/pop-os/cosmic-panel";
    description = "Panel for the COSMIC Desktop Environment";
    mainProgram = "cosmic-panel";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
