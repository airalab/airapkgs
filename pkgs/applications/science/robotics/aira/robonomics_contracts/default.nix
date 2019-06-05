{ stdenv
, fetchFromGitHub
, pkgs
, makeWrapper
, nodejs-8_x
, buildEnv
}:

let
  nodePackages = import ./node.nix { inherit pkgs; };
  nodeEnv = buildEnv {
    name = "robonomics_contracts-env";
    paths = stdenv.lib.attrValues nodePackages;
  };

in stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "robonomics_contracts";
  version = "v1.0";

  src = fetchFromGitHub {
      owner = "airalab";
      repo = pname;
      rev = version;
      sha256 = "17lrlsfczjc9j80y0v7svpxlayc011gl8g10xpwp2kkdpb9f45bb";
  };

  prePatch = ''
    ln -s config.js.example config.js
    mkdir node_modules
    cp -R ${nodePackages."openzeppelin-solidity-2.1.3"}/lib/node_modules/openzeppelin-solidity node_modules
    cp -R ${nodePackages."truffle-5.0.2"}/lib/node_modules/truffle node_modules
    chmod 755 node_modules/truffle/build/
    chmod 755 node_modules/truffle/build/cli.bundled.js
    echo "truffle moved"
  '';

  patches = [ ./cache-on-tmpdir.patch ];

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ nodejs-8_x ];

  buildPhase = ''
    mkdir -p $out/bin
    cp -R . $out/

    cat > $out/bin/robonomics_migrate <<EOF
      #!${stdenv.shell}/bin/sh
      pushd $out
      exec $out/node_modules/truffle/build/cli.bundled.js migrate --contracts_build_directory /tmp/contracts/ "\$@"
    EOF
  '';

  installPhase = ''
    chmod +x $out/bin/robonomics_migrate
    wrapProgram $out/bin/robonomics_migrate \
      --set NODE_PATH "${nodeEnv}/lib/node_modules"
  '';

  meta = with stdenv.lib; {
    description = "Robonomics platform smart contracts";
    homepage = http://github.com/airalab/robonomics_contracts;
    license = licenses.bsd3;
    maintainers = with maintainers; [ akru strdn ];
  };

}
