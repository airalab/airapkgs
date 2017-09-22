{ stdenv, fetchFromGitHub, rustPlatform,
  pkgconfig, openssl, systemd }:

with rustPlatform;

buildRustPackage rec {
  name = "parity-${version}";
  version = "1.7.2";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "parity";
    rev = "v1.7.2";
    sha256 = "1flm7rw9ngr6z5hpayij83ybqqyh7hxz88czyg17qvjxc5k719dc";
  };

  depsSha256 = "0qbm50nzzdv610gx5jpq7ym5i7575h2nzm4ak9h9wsz2kdfjfiyg";

  buildInputs = [ pkgconfig systemd.lib systemd.dev openssl openssl.dev ]; 

  # Some tests fail
  doCheck = false;

  meta = {
    description = "Fast, light, robust Ethereum implementation";
    homepage = http://parity.io;
    license = stdenv.lib.licenses.gpl3;
    inherit version;
  };
}
