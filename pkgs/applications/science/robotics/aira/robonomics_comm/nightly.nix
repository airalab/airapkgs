{ stdenv
, ros_comm
, mkRosPackage
, python3Packages
, python3
, fetchFromGitHub
}:

let
  rev = "4a921c441cab33f69bf3604e3c3a7ddf9c46ed31";
  sha256 = "0i66fdjg00v3gfyf90vyrba3jvvhp6i64h7x454y2yg4nz1hbvnl";

in mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "robonomics_comm";
  version = builtins.substring 0 8 rev;

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    inherit rev sha256;
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm web3 multihash voluptuous ipfsapi python-persistent-queue ];

  postInstall = ''
    patch $out/lib/${python3.libPrefix}/site-packages/ethereum_common/msg/_UInt256.py $src/ethereum_common/msg/_UInt256.py.patch
  '';

  meta = with stdenv.lib; {
    description = "Robonomics communication stack";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
