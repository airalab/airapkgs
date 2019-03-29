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
  version = "0.3.21";

  src = fetchFromGitHub {
    owner = "akru";
    repo = "polkadot";
    rev = "v${version}";
    sha256 = "0x0rf3bi45axr6jnsayy26vnzwfw7xmky8w7syd4nv0an8g3k40i";
  }; 

  cargoSha256 = "173xkapmg6dsvs1v2hcp2k8svzrf45dkiqxkrlpkzarbkqf79i1a";

  buildInputs = [ pkgconfig openssl openssl.dev clang ];
  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with stdenv.lib; {
    description = "Polkadot Node Implementation";
    homepage = http://polkadot.network;
    license = licenses.gpl3;
    maintainers = [ maintainers.akru ];
    platforms = platforms.linux;
  };
}
