{
  fetchurl,
  lib,
  stdenvNoCC,
}: let
  version = "0.41.0";
in
  stdenvNoCC.mkDerivation {
    pname = "codexbar-cli";
    inherit version;

    src = fetchurl {
      url = "https://github.com/steipete/CodexBar/releases/download/v${version}/CodexBarCLI-v${version}-linux-musl-x86_64.tar.gz";
      hash = "sha256-6b/voFbBsI7QMhg8MhpRdTgJ2Ifa//JP0wjGkTS1MQs=";
    };

    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 CodexBarCLI $out/bin/codexbar
      runHook postInstall
    '';

    meta = {
      description = "Codex usage limits CLI";
      homepage = "https://github.com/steipete/CodexBar";
      license = lib.licenses.mit;
      mainProgram = "codexbar";
      platforms = ["x86_64-linux"];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }
