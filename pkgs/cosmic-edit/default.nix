{
  cosmic-edit,
  fetchFromGitHub,
}:
cosmic-edit.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-06-02";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-edit";
    rev = "34eecb7dcd26c5eeb1cb8e8e1abfde1ca13468cd";
    hash = "sha256-fQmVDHc5C+aId+wH+6Jtqhx7F0rxmLYKt/7XhXsr0CY=";
  };

  cargoHash = "sha256-InzFwzGUM4IH8kaULzLboDfwc6U5fcTdN6+sx5SLZJo=";
})
