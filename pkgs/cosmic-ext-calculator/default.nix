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
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-calculator";
  version = "999";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "calculator";
    rev = "277343ec73ae00d5d350a8993d1b5a5c46f3fbcd";
    hash = "sha256-UO3JKPsztptNEFAxolRui9FxtCsTRgpXhHH242i9b6E=";
  };

  cargoHash = "sha256-a4IOmCWKX8RR8xeKS6wdsTlNyTr91B93bYMDx/+/+04=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-calculator"
  ];

  meta = {
    changelog = "https://github.com/cosmic-utils/calculator/releases/tag/${version}";
    description = "Calculator for the COSMIC Desktop Environment";
    homepage = "https://github.com/cosmic-utils/calculator";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-ext-calculator";
    platforms = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
