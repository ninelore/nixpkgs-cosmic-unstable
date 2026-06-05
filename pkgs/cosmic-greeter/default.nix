{
  cosmic-greeter,
  fetchFromGitHub,
}:

cosmic-greeter.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-greeter";
    rev = "2290aae5e2e078a1d79c6ec1a27cdf3ccc366a45";
    hash = "sha256-GOHuuMVUd9LPRvmEYHuAxSoMz59/3uuAMjiRzpoUX/w=";
  };

  cargoHash = "sha256-5A+7sgZqJcXjK51i5thAm9LK1SrW9ly8NHyf3IZfWQA=";

  env.VERGEN_GIT_SHA = finalAttrs.src.rev;
})
