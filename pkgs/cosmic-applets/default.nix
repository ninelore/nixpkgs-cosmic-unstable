{
  cosmic-applets,
  fetchFromGitHub,
  rustPlatform,
}:

cosmic-applets.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-05-29";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-applets";
      rev = "95eda4087814f624b52e97e8f65d75432fd01eb2";
      hash = "sha256-aXVeUMGsSbNRcmth8evFqBp7++hzc+Go+lFBh03yaiw=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
