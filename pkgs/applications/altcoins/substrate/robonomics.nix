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
  version = "0.10.2";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "substrate-node-robonomics";
    rev = "v${version}";
    sha256 = "04384qrda0dj44sas48kgwgjkv5bhjxfy6dzfl4ryh9h7f7f504v";
  }; 

  cargoSha256 = "1bh9fjzcgvwgl621d24h5z0xvm7aj4z2amb80grgafdma4pbvv4b";

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
