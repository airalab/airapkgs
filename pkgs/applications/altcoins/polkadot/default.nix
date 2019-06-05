{ stdenv
, fetchFromGitHub
, rustPlatform
, llvmPackages
, pkgconfig
, openssl
, clang
}:

rustPlatform.buildRustPackage rec {
  name = "polkadot-${version}";
  version = "0.4.4";

  src = fetchFromGitHub {
    owner = "akru";
    repo = "polkadot";
    rev = "v${version}";
    sha256 = "1zq2fhpgyhhfjr7hvhpp0lghs76l722mswb1rlxih96kma6xafsj";
  }; 

  cargoSha256 = "0ma1cx9bcwdcbcxy6yvf38g1g1q3l02kmrrz3ggv667as23c6pnz";

  buildInputs = [ pkgconfig openssl openssl.dev clang ];
  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with stdenv.lib; {
    description = "Polkadot Node Implementation";
    homepage = https://polkadot.network;
    license = licenses.gpl3;
    maintainers = [ maintainers.akru ];
    platforms = platforms.linux;
  };
}
