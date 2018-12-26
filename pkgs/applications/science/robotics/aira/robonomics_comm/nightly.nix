{ stdenv
, ros_comm
, mkRosPackage
, python3Packages
, fetchFromGitHub
}:

let
  rev = "77db2a89debfc40f87add9c998ec6e7aba116fd4";
  sha256 = "101jrap8kqxbzlbp1gsp56xd0rllra2w580vdmr84qs92qb7am2h";

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

  meta = with stdenv.lib; {
    description = "Robonomics communication stack";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
