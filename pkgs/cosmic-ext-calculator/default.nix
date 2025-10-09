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
  version = "0.2.0-unstable-2025-09-30";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "calculator";
    rev = "455f28c9ae445fa30f91e570ab2eaccbf28e8461";
    hash = "sha256-cVwo+iP6tGTQDq2d4EeUOIIVjNdh7/aqRXxio4AFGzc=";
  };

  cargoHash = "sha256-Pq1E4O6lZMe+wKJgQKDBmgdsJJsJTyK0FDXU53n+Di4=";

  patches = [ ./0001-justfile-fix-un-install.patch ];

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
