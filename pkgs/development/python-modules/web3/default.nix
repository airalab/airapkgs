{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, lru-dict 
, requests
, eth-abi
, eth-account
, websockets6
}:

let
  pname = "web3";
  version = "4.8.3";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}.py";
    rev = "v${version}";
    sha256 = "1dxdw55znjbpacp0128w7bivkfq4sr0v9aaxx8wpn1anijy1kvy8";
  };

  patches = [ ./append-sid-tld.patch ];

  propagatedBuildInputs = [ lru-dict requests eth-abi eth-account websockets6 ];

  disabled = pythonOlder "3.3";

  # No testing
  doCheck = false;

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "A python interface for interacting with the Ethereum blockchain and ecosystem.";
    homepage = https://github.com/ethereum/web3.py;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
