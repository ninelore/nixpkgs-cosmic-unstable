{
  cosmic-player,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-player.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-06-03";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-player";
      rev = "c0b1bda86bc4dd86f52c97c55a820493b6273d26";
      hash = "sha256-iDEyR+P+iXShH0YFtqxvPbbs9kgtYvAsuKchB6plnKI=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
