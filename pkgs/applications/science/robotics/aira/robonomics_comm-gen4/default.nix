{ stdenv
, ros_comm
, mkRosPackage
, python3Packages
, fetchFromGitHub
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "robonomics_comm";
  version = "1.0.0-rc1";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "1534f1bc36eedeb8ea444a9ea1fff7d7a6706bf0";
    sha256 = "05xr64240cwp5xm68n056lfb31ii3a6xsaiwf09c0s7ypgk3ba03";
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
