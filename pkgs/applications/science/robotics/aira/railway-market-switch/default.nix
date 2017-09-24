{ stdenv, fetchFromGitHub, haskellPackages, pkgs }:

with haskellPackages;

mkDerivation {
  pname = "railway-market-switch";
  version = "0.2";

  isLibrary = false;
  isExecutable = true;

  libraryHaskellDepends = with pkgs;
  [ base web3 z21 miku warp text queue logging transformers ];

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "railway-market-switch";
    rev = "0.2";
    sha256 = "1aqs2hba3nzsvzzy3wmkbyzxbw0zxkdznljdl8br80dpvkhkdwxg";
  };
  
  homepage = http://github.com/airalab/railway-market-switch;
  license = stdenv.lib.licenses.bsd3;
}
