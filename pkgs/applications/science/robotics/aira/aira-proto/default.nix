{ stdenv, fetchFromGitHub, haskellPackages, hs-multihash, ipfs }:

with haskellPackages;

mkDerivation {
  pname = "aira-proto";
  version = "0";

  isLibrary = true;
  isExecutable = true;

  libraryHaskellDepends =
  [ base transformers bytestring hs-multihash logging memory shelly
    async text web3 mtl ];

  executableHaskellDepends =
  [ base web3 ];

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "aira-proto";
    rev = "b480b861f10aed26a8d8b3c5181377d3772fe14b";
    sha256 = "1cw731cq7wk85iwx967c43qbck5mhh2ircjvzdh44f86g68mpfc2";
    fetchSubmodules = true;
  };
  
  homepage = http://github.com/airalab/aira-proto;
  license = stdenv.lib.licenses.bsd3;
}
