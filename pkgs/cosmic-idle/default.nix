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
  bash,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-idle";
  version = "epoch-1.0.0-alpha.7-unstable-2025-02-25";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-idle";
    rev = "267bb837f127eb805a17250ebcad02db57eb72cb";
    hash = "sha256-dRvcow+rZ4sJV6pBxRIw6SCmU3aXP9uVKtFEJ9vozzI=";
  };

  cargoHash = "sha256-iFR0kFyzawlXrWItzFQbG/tKGd3Snwk/0LYkPzCkJUQ=";

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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-idle"
  ];

  postPatch = ''
    substituteInPlace src/main.rs --replace-fail '"/bin/sh"' '"${lib.getExe' bash "sh"}"'
  '';

  meta = {
    description = "Idle daemon for the COSMIC Desktop Environment";
    homepage = "https://github.com/pop-os/cosmic-idle";
    license = lib.licenses.gpl3Only;
    mainProgram = "cosmic-idle";
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
})
