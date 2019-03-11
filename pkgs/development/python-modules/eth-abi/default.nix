{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
, parsimonious
, pytest
, hypothesis
}:

let
  pname = "eth-abi";
  version = "1.3.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "0df8s5zh59h4y7kbqff7bfvzyc36lvdyhny871j019qriyg0vl7z";
  };

  buildInputs = [ pytest hypothesis ];
  propagatedBuildInputs = [ eth-utils parsimonious ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Ethereum ABI Utils";
    homepage = https://github.com/ethereum/eth-abi;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
