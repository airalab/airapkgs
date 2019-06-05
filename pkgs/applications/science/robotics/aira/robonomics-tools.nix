{ mkDerivation, aeson, async, base, base58string, bytestring
, exceptions, generics-sop, hashable, hpack, pipes, memory
, microlens, monad-control, monad-logger, mtl, optparse-applicative
, containers, cryptonite, data-default, process, stdenv, text, web3
, fetchFromGitHub
}:

mkDerivation rec {
  pname = "robonomics-tools";
  version = "0.5.1.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    rev = "v${version}";
    sha256 = "1cv8mfx7gzic2xxsfhallhap1c50b6fwxc4rwr8xm7adwxbbwslb";
  };

  isLibrary = false;
  isExecutable = true;

  preConfigure = "${hpack}/bin/hpack";
  executableHaskellDepends = [
    aeson async base base58string bytestring pipes
    containers cryptonite data-default exceptions generics-sop
    memory microlens monad-control monad-logger mtl hashable
    optparse-applicative process text web3
  ];

  homepage = "https://github.com/airalab/robonomics-tools#readme";
  description = "Robonomics.network tools";
  license = stdenv.lib.licenses.bsd3;
  maintainers = with stdenv.lib.maintainers; [ akru ];
}
