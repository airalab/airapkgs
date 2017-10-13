{ stdenv, fetchFromGitHub, haskellPackages, hs-multihash, ipfs }:

with haskellPackages;

mkDerivation {
  pname = "aira-proto";
  version = "0";

  isLibrary = true;
  isExecutable = true;

  libraryHaskellDepends =
  [ base transformers bytestring hs-multihash logging memory shelly
    optparse-generic async text web3 mtl ];

  executableHaskellDepends =
  [ base web3 ];

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "aira-proto";
    rev = "bbdeb8c0440452de7cf4334f7bc0b98560d7ba9e";
    sha256 = "0kvsk0anrbn67vm0nvna33bsbbziq73r84bf7446k2v2clq8brkm";
    fetchSubmodules = true;
  };
  
  homepage = http://github.com/airalab/aira-proto;
  license = stdenv.lib.licenses.bsd3;
}
