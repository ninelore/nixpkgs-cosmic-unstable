{
  cosmic-screenshot,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-screenshot.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-06-01";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-screenshot";
      rev = "2020fb21accb65e94fe0b3f8270e5e3359cafabe";
      hash = "sha256-DngKZDKfgVdSZLZAsPq+7p4r/go2Y6141LrCNGoxD1E=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
