{ stdenv, pkgs, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "console-bridge";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "ros";
    repo = "console_bridge";
    rev = "0.3.2";
    sha256 = "0yzzi2dx4plflnas7ipn1xpmaw2rcy45wd19da24r31fkv7xjys0";
  };

  nativeBuildInputs = with pkgs; [ cmake pkgconfig ];
}
