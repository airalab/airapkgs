{ stdenv
, fetchFromGitHub
, rustPlatform
, llvmPackages
, pkgconfig
, ncurses
, openssl
, clang
}:

rustPlatform.buildRustPackage rec {
  name = "${pname}-${version}";
  pname = "grin";
  version = "1.1.0-beta.2";

  src = fetchFromGitHub {
    owner = "mimblewimble";
    repo = pname; 
    rev = "v${version}";
    sha256 = "0rlcnw5dmc3pic5x91s1zac638ns5xryyz6x1zzkgbd1fl5r1nd9";
  }; 

  cargoSha256 = "1xi1c3fc28yy9d02indgabrzgr4gdam15amwzgl2xcrcy7f4z02m";

  buildInputs = [ pkgconfig openssl openssl.dev clang ncurses ];
  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with stdenv.lib; {
    description = "Minimal implementation of the MimbleWimble protocol.";
    homepage = http://grin-tech.org/;
    license = licenses.asl20;
    maintainers = [ maintainers.akru ];
    platforms = platforms.linux;
  };
}
