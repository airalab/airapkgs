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
  pname = "substrate-node";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "substrate";
    rev = "72409f9fd1dcf25b094dc09a31a9f831dd56411a";
    sha256 = "0b40c2g151mm0vgh8sbz9kqxr541256x2mhdv2mskhlkkcggx5f7";
  }; 

  cargoSha256 = "1amq6zkb1aq2qjiq5xxl3zwihh0zm098nfi814fmg3h8qan5x52v";

  buildInputs = [ pkgconfig openssl openssl.dev clang ];
  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with stdenv.lib; {
    description = "Substrate: The platform for blockchain innovators";
    homepage = https://github.com/paritytech/substrate;
    license = licenses.gpl3;
    maintainers = [ maintainers.akru ];
    platforms = platforms.linux;
  };
}
