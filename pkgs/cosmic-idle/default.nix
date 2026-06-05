{
  cosmic-idle,
  fetchFromGitHub,
}:
cosmic-idle.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-02-13";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-idle";
    rev = "c95d066b5b640509a6369634b669ca60dc50e168";
    hash = "sha256-0tcrOfVT5b57ev3b5F2U78F2QPGFwp94bqFVNyKH0Yk=";
  };

  cargoHash = "sha256-MI52HOBKpmbreOSrnWAJ45IZtbxNUWL69iocjRbGDa8=";
})
