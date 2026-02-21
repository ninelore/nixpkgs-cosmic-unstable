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
  version = "0.2.0-unstable-2026-02-20";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "tweaks";
    rev = "282ab24981f16dfc71a146987f9e5c495c8cf178";
    hash = "sha256-o/Ka8Fo1yL02zYhG1zkr62bhW2cKG6laRe9hCm4oDb0=";
  };

  cargoHash = "sha256-6YrgLmzUOgaWsidf0P0pp77yGuwhfMnrppcXptnkRnE=";

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
