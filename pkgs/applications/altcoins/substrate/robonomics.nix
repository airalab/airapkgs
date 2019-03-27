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
    sha256 = "1ld5fx9nkqcdbkrn6sidha4p4k3px1vplmv58g9vr9if7zflq0av";
  }; 

  cargoSha256 = "02sr6d1jc8rfp41cim2xrp1kryr9gbxgns0vbz03yiysiv79d0yr";

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
