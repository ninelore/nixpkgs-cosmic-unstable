{
  cosmic-workspaces-epoch,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-workspaces-epoch.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "cosmic-workspaces-epoch";
    version = "epoch-1.0.16-unstable-2026-05-26";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-workspaces-epoch";
      rev = "5e62de143a02073200b075036626f56ad4140589";
      hash = "sha256-u4p22qpxZPdBogzrJXGomqGGxgkpD0hdXf+3YNg2VIo=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
