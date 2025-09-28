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
  version = "0.2.0-unstable-2025-09-27";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "calculator";
    rev = "bfa687790bed060b41fd4d0e34cceed9d7dc9c51";
    hash = "sha256-M9AVcXCbYTYBevkfBHdbM7ayPjhL+OcO9yhsmJDO41A=";
  };

  cargoHash = "sha256-Pq1E4O6lZMe+wKJgQKDBmgdsJJsJTyK0FDXU53n+Di4=";

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
