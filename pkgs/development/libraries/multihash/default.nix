{ stdenv, fetchFromGitHub, haskellPackages }:

with haskellPackages;

mkDerivation {
  pname = "multihash";
  version = "0.2.1";

  isLibrary = true;
  isExecutable = false;

  libraryHaskellDepends =
  [ base attoparsec base58-bytestring base64-bytestring bytestring
    cryptonite hex io-streams memory byteable optparse-applicative ];

  src = fetchFromGitHub {
    owner = "akru";
    repo = "haskell-multihash";
    rev = "7097b48e6e1b7e73820ccf64e1a5bcd5b0389237";
    sha256 = "15fp9mvy9vhsmr0pwr61b88cgsq7fgsml0yfa7nrlaacy2gvpqin";
  };
  
  homepage = http://github.com/MatrixAI/haskell-multihash;
  license = stdenv.lib.licenses.bsd3;
}
