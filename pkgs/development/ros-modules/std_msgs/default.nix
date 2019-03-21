{ stdenv
, mkRosPackage
, fetchFromGitHub
, message_generation
, message_runtime
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "std_msgs";
  version = "0.5.12";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "std_msgs-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0zi3c11c0xrlz2ikjrjw9v3587blikplyry2wfdzavxzd44hf8w9";
  };

  propagatedBuildInputs = [ message_generation message_runtime ];

  meta = with stdenv.lib; {
    description = "Common message types representing primitive data types and other basic message constructs";
    homepage = http://wiki.ros.org/std_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
