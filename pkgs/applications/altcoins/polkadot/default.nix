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
  version = "0.3.20";

  src = fetchFromGitHub {
    owner = "akru";
    repo = "polkadot";
    rev = "v${version}";
    sha256 = "10gjas3g56b1rmviq31gs8ca658idh56xayi42726dyyc9db8gka";
  }; 

  cargoSha256 = "0ncmcrci559v4hmh3w9hwm0ym9qjdqviahsgix425jglpqp3jsvd";

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
