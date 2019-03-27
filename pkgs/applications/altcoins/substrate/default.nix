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
    rev = "c0556a24cdc51545e10d2e95e78c50a69430046a";
    sha256 = "133bjm8z9wy4xq9j40hslwlhvydl2k8k11b1lmw5r4aq5s88pmm6";
  }; 

  cargoSha256 = "0001sg94ivrnkrhmi11b7n3jbh5p242bh15ypfq2ip9q3kkh6wan";

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
