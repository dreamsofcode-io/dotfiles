{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "gptscript";
  version = "0.6.0";
  src = fetchurl {
      url = "https://github.com/gptscript-ai/gptscript/releases/download/v0.6.0/gptscript-v0.6.0-linux-amd64.tar.gz";
      sha256 = "+5dnyf+zF/tDyPxJsKeCzF64HKu9FmOqIsR8hbg14FE=";
  };

  sourceRoot = ".";
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r gptscript  $out/bin/gptscript
    chmod +x $out/bin/gptscript
  '';
}
