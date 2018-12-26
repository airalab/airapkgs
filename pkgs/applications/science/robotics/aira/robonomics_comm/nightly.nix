{ stdenv
, ros_comm
, mkRosPackage
, python3Packages
, fetchFromGitHub
}:

let
  rev = "b810246e49ef5412004910e1adb44fd4a55f6f09";
  sha256 = "09di9vwaqzg6adv8qh3kmrjn52djwpn73133g449kn91w2zjbf6z";

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
