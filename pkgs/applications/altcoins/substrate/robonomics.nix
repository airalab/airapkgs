{ stdenv
, fetchFromGitHub
, rustPlatform
, llvmPackages
, pkgconfig
, openssl
, clang
}:

rustPlatform.buildRustPackage rec {
  name = "${pname}-${version}";
  pname = "substrate-node-robonomics";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "substrate-node-robonomics";
    rev = "next";
    sha256 = "1sqb0hnr71s9dqv9d3sjcjq27g2rp291qv3c64kq35p2ad258nyk";
  }; 

  cargoSha256 = "0s61hksl8qky5cnvgrbh951bagxzkj2nv68q0g6svhvhjkqc9scs";

  buildInputs = [ pkgconfig openssl openssl.dev clang ];
  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with stdenv.lib; {
    description = "Robonomics on Substrate";
    homepage = https://github.com/airalab/substrate-node-robonomics;
    license = licenses.asl20;
    maintainers = [ maintainers.akru ];
    platforms = platforms.linux;
  };
}
