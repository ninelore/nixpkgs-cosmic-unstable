{
  cosmic-reader,
  fetchFromGitHub,
  rustPlatform,
}:
cosmic-reader.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "cosmic-reader";
    version = "0-unstable-2026-06-06";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-reader";
      rev = "31485419db10e12c2942029d673836343e4609dd";
      hash = "sha256-XZ5A7Qi+sxlUel1Fpr9wy8o0MD9mtyqFIwBN4Rf7CcU=";
    };

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
    };
  }
)
