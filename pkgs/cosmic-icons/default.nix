{
  cosmic-icons,
  fetchFromGitHub,
}:
cosmic-icons.overrideAttrs (
  finalAttrs: prevAttrs: {
    version = "epoch-1.0.15-unstable-2026-04-29";

    src = fetchFromGitHub {
      owner = "pop-os";
      repo = "cosmic-icons";
      rev = "b78b059636ed967ad7c6f120709c7d29b2bafac1";
      hash = "sha256-QUTAYIQ6qAhjZK/9BZjJzTViECLUwO/MyaOqiRb1Ans=";
    };
  }
)
