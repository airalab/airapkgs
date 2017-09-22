{ stdenv, fetchFromGitHub, haskellPackages, pkgs }:

with haskellPackages;

mkDerivation {
  pname = "railway-market-switch";
  version = "0.1.1";

  isLibrary = false;
  isExecutable = true;

  libraryHaskellDepends = with pkgs; [ base web3 z21 miku warp queue transformers ]; 

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "railway-market-switch";
    rev = "0.1.1";
    sha256 = "00scgzrjn7m0dzx4fs52zjrad4g9bqkiwggb9s2wxbxrl1a107jg";
  };
  
  homepage = http://github.com/airalab/railway-market-switch;
  license = stdenv.lib.licenses.bsd3;
}
