{
  cosmic-icons,
  fetchFromGitHub,
}:
cosmic-icons.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-04-29";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-icons";
    rev = "2c697e8e97cfd619107a872b28c31317281184ff";
    hash = "sha256-3owl4M4vRyzjR4v74clyAxpNDu77rieSpYAVYfADHzY=";
  };
})
