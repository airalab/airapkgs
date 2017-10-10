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
    rev = "b2ecb24f769e99fccc67d906d2b208b636b3b12c";
    sha256 = "08a32n4psx1fm30r4lypalv4vqzs94f9pfaycy93myb02sj28v7x";
    fetchSubmodules = true;
  };
  
  homepage = http://github.com/airalab/aira-proto;
  license = stdenv.lib.licenses.bsd3;
}
