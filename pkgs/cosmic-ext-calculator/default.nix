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
  version = "0.1.1-unstable-2025-09-21";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "calculator";
    rev = "c7c963d09fbba88ab3fec4b92873948ecc2a3196";
    hash = "sha256-PNGEV9zXh6tydavz5nA9El2mzei+OabTLYmLjPdq0lY=";
  };

  cargoHash = "sha256-zyRJZe/jTORN8268HcoQKmmRUqzZS9dEfs05tA4BXaE=";

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
