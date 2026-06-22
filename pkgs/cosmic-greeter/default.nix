{
  cosmic-greeter,
  fetchFromGitHub,
}:

cosmic-greeter.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "7a0c083f0151cebd35648920ca43c7aaa16cdf93";
    hash = "sha256-+6VOv6z61k48hURq4yRRMIFIE8ZrjYGapO5FybWKQTE=";
  };

  cargoHash = "sha256-mfY2hsMxBooRjmTB2jgUIKyKHBpGfZ9Qslwv+2aEQyg=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;
})
