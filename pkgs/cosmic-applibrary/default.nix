{
  cosmic-applibrary,
  fetchFromGitHub,
}:

cosmic-applibrary.overrideAttrs (finalAttrs: {
  version = "epoch-1.0.15-unstable-2026-05-26";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "cosmic-applibrary";
    rev = "aaf0c4e919aaf2a680ca47f1cf8c17686605b303";
    hash = "sha256-AZ054mMIGkQx9o/TSRMDqhhp1VyAyTXQSD2IIuhYDm8=";
  };

  cargoHash = "sha256-HvsSK6HO2xQzpdHvUZgkv5cTZsim0ST2lslD+D7qjVs=";
})
