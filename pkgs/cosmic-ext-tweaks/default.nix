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
  version = "0.2.2-unstable-2026-05-06";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "tweaks";
    rev = "dfb5fd8dad5d7e785369b72031f6ec865bfa841b";
    hash = "sha256-p6XhIM2Hbc++Q9oLHBv+h1WKBdEpMSinCdDf7EQBZzU=";
  };

  cargoHash = "sha256-iMkcBMwgb2mhODwbp451nKvRSprSAuXHQ+9Fh5S+Ojk=";

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
