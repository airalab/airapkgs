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
    rev = "7a5bfe092f69a156b8b2f52049b3d941ee764c56";
    sha256 = "1fq787xfj98aqz6y710s73nc2ibjacm83slsn98pirg9jzq4gnbm";
    fetchSubmodules = true;
  };
  
  homepage = http://github.com/airalab/aira-proto;
  license = stdenv.lib.licenses.bsd3;
}
