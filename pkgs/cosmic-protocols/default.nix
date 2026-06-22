{
  cosmic-protocols,
  fetchFromGitHub,
}:
cosmic-protocols.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "0-unstable-2026-05-08";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-protocols";
      rev = "c253ec1d6804afbcdf250f5cc37ae1194bba7bd2";
      hash = "sha256-KO7VTxomhrnwzFlkkXSoP0eh3NRShBD4srW5W6temxo=";
    };
  }
)
