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
  version = "1.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "substrate";
    rev = "v${version}";
    sha256 = "1ssvsl4qy9mv2x17vm54nsan4s75zj38mwyy8fv2m851hss98jc6";
  }; 

  cargoSha256 = "1m1cf2smw3bs34vlnxzh564cvk3iz00ay4gn9nhb0d6xxyjbcbn7";

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
