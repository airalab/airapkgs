{ stdenv, fetchFromGitHub, haskellPackages }:

with haskellPackages;

mkDerivation {
  pname = "z21";
  version = "0.1";

  isLibrary = true;
  isExecutable = false;

  libraryHaskellDepends = [ base base16-bytestring binary-conduit
                            conduit-extra bytestring conduit network binary ];

  src = fetchFromGitHub {
    owner = "akru";
    repo = "z21-hs";
    rev = "0.1";
    sha256 = "0qk5fxpdhl7gw9h9hwarvcafm8szp7x75qwiyg55p0wskqx94b46";
  };
  
  homepage = http://github.com/akru/z21-hs;
  license = stdenv.lib.licenses.bsd3;
}
