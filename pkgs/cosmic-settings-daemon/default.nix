{
  cosmic-settings-daemon,
  fetchFromGitHub,
}:
cosmic-settings-daemon.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-settings-daemon";
    rev = "fa82bdf9fe7b5f5bd6008f32f393efd5e7a71c47";
    hash = "sha256-A+nOAadFWU+KRW54dP2WW6P6fabIs4z1AqC37LSZjUI=";
  };

  cargoHash = "sha256-bz+JasI3WE30sKKgjofVO/42Ml4YY9Dw3JxnZmZVQk4=";
})
