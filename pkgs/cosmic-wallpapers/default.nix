{
  cosmic-wallpapers,
  fetchFromGitHub,
}:
cosmic-wallpapers.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-02-13";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-wallpapers";
      rev = "3c59953e7ee5792efecdb232cb4c7211e7785f52";
      forceFetchGit = true;
      fetchLFS = true;
      hash = "sha256-m2cYppfitpBDKK8CC9i/lUrC9rfSYTuqUSZSyIKKGyg=";
    };
  }
)
