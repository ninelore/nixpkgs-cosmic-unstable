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
  version = "0.2.0-unstable-2026-02-12";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "tweaks";
    rev = "bb541b9e97094670f29975ebd9962396cf28ca41";
    hash = "sha256-W0mdeqHOv2gjO6pgjNsHzE3mQxx7QKqCqWb2J/DE4xY=";
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
