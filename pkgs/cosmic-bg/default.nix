{
  cosmic-bg,
  fetchFromGitHub,
}:

cosmic-bg.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-04-30";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-bg";
    rev = "ed65f7d3dc9e3d4af3cd65244a966e01bff0f730";
    hash = "sha256-yPUbkcQmJGOcKkpi3pfHHW8ggw7juTW3GHD8l+kDI9w=";
  };

  cargoHash = "sha256-xXq8Dckg3YOf2AT9uOZqVfq00FhZp/X5UU8hLmAln1U=";
})
