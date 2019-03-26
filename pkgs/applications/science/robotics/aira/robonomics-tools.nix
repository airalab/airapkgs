{ mkDerivation, aeson, async, base, base58-bytestring, bytestring
, concurrent-machines, containers, cryptonite, data-default
, exceptions, generics-sop, hashable, hpack, machines, memory
, microlens, monad-control, monad-logger, mtl, optparse-applicative
, process, secp256k1-haskell, stdenv, text, web3, fetchFromGitHub
}:

mkDerivation rec {
  pname = "robonomics-tools";
  version = "0.4.0.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    rev = "v${version}";
    sha256 = "1gl38ifwvzij6xyp3cf5n83fbkv66v721dla7r8vxq3wy21hb2rx";
  };

  isLibrary = true;
  isExecutable = true;

  libraryHaskellDepends = [
    aeson async base base58-bytestring bytestring concurrent-machines
    containers cryptonite data-default exceptions generics-sop hashable
    machines memory microlens monad-control monad-logger mtl
    optparse-applicative process text web3
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson async base base58-bytestring bytestring concurrent-machines
    containers cryptonite data-default exceptions generics-sop hashable
    machines memory microlens monad-control monad-logger mtl
    optparse-applicative process text web3
  ];
  testHaskellDepends = [
    aeson async base base58-bytestring bytestring concurrent-machines
    containers cryptonite data-default exceptions generics-sop hashable
    machines memory microlens monad-control monad-logger mtl
    optparse-applicative process text web3
  ];
  preConfigure = "hpack";

  homepage = "https://github.com/airalab/robonomics-tools#readme";
  description = "Robonomics.network tools";
  license = stdenv.lib.licenses.bsd3;
  maintainers = with stdenv.lib.maintainers; [ akru ];
}
