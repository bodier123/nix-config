{ stdenv, hello }:
stdenv.mkDerivation {
  name = "hello-wrapped";
  buildInputs = [ hello ];
  installPhase = ''
    mkdir -p $out/bin
    ln -s ${hello}/bin/hello $out/bin/hello
  '';
}
