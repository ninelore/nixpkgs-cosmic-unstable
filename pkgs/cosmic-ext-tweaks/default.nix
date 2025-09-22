# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Lily Foster <lily@lily.flowers>
# Portions of this code are adapted from nixos-cosmic
# https://github.com/lilyinstarlight/nixos-cosmic
{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libcosmicAppHook,
  just,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-tweaks";
  version = "0.1.3-unstable-2025-09-21";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "tweaks";
    rev = "0abd94eb76b6018bee9adddb345a55745d659af4";
    hash = "sha256-JWWKjaIxaq2XCOzht2Nl5oErG6D3xcJSYXlgSy0S42s=";
  };

  cargoHash = "sha256-ZFaL6qEKzSGZzOtcJX32wti0ivdA7CbYGREPFWZvxmc=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];

  buildInputs = [ openssl ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-tweaks"
  ];

  meta = {
    changelog = "https://github.com/cosmic-utils/tweaks/releases/tag/${version}";
    description = "Tweaking tool for the COSMIC Desktop Environment";
    homepage = "https://github.com/cosmic-utils/tweaks";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-ext-tweaks";
    platforms = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
