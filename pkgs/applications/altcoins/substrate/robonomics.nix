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
    rev = "v${version}";
    sha256 = "00gnr8sbfxivfqr5a624lrx8mmizalq60jpw02iqp0blx4pxa3gp";
  }; 

  cargoSha256 = "03kpimpzsfs3cgpx9l2wff26c7xwg5cqjci57d70blsx234w9b4z";

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
