{
  cosmic-reader,
  fetchFromGitHub,
}:
cosmic-reader.overrideAttrs (finalAttrs: {
  pname = "cosmic-reader";
  version = "0-unstable-2026-05-20";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-reader";
    rev = "c29b3e82c0827133b24dcdb43e1f28a1c7df37a1";
    hash = "sha256-YsRXWSf2l8RfIEXKxvJtYWxhma8N2Y+0/HZwhs7d5k8=";
  };

  cargoHash = "sha256-P9ZC7721MjC/h7sbf7x91WGfMbT4tA46HrYhDgCeiWE=";
})
