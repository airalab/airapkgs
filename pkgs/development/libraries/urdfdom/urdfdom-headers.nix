{ stdenv, pkgs, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "urdfdom-headers";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "ros";
    repo = "urdfdom_headers";
    rev = "${version}";
    sha256 = "13qp5bbsjmgyq0r008x6arrv5npk4g2y2vgz4xw2jyf3b81cx7gk";
  };

  nativeBuildInputs = with pkgs; [ cmake ];
}
