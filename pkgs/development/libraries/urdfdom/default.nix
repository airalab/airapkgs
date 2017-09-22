{ stdenv, pkgs, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "urdfdom";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "ros";
    repo = "${name}";
    rev = "${version}";
    sha256 = "0067x4gj6j0k1inhxvyffnnnlrsks2dzgmiql4cxj7jncm8agbyl";
  };

  nativeBuildInputs = with pkgs;
  [ cmake pkgconfig tinyxml urdfdom-headers console-bridge boost ];
}
