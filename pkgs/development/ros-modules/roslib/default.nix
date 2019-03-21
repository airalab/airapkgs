{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_environment
, rospack
, boost
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "roslib";
  version = "1.14.6";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1zsx3jp24aipvv97pb4527825xd70hh71q4k5lz3agsdypgnrmwr";
  };

  buildInputs = [ boost ];
  propagatedBuildInputs = [ rospack ros_environment ];

  meta = with stdenv.lib; {
    description = "Base dependencies and support libraries for ROS";
    homepage = http://wiki.ros.org/roslib;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
