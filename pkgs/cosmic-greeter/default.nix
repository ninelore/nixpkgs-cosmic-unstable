{
  cosmic-greeter,
  fetchFromGitHub,
}:

cosmic-greeter.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "178d5222ee580377f91b25e4e01ed98597d39664";
    hash = "sha256-hnxKnFVATIOCPUWUtCekc7+lFrm/2u8lALyDBI/b/U4=";
  };

  cargoHash = "sha256-mfY2hsMxBooRjmTB2jgUIKyKHBpGfZ9Qslwv+2aEQyg=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;
})
