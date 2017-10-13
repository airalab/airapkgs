{ stdenv, fetchFromGitHub, haskellPackages, pkgs }:

with haskellPackages;

mkDerivation {
  pname = "github-ipfs";
  version = "0.1";

  isLibrary = false;
  isExecutable = true;

  libraryHaskellDepends = with pkgs;
  [ base servant-github-webhook servant-server bytestring shelly aeson text warp ];

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "github-ipfs";
    rev = "533b6397cb7f6375c09e85e2bfa8deb183cb8715";
    sha256 = "0gvh81rfzwkv19ak3i4pclany35i74avh7q6ms9vcnqsi6nfz8zx";
  };
  
  homepage = https://github.com/airalab/github-ipfs;
  license = stdenv.lib.licenses.bsd3;
}