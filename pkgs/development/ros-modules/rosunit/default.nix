{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, roslib
}:

let
  pname = "rosunit";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1r8igvbmyhnwjflianshifcykgpvbcfcs4smg1qf78bb0grh6a7w";
  };

  propagatedBuildInputs = [ catkin roslib ];

  meta = with stdenv.lib; {
    description = "Unit-testing package for ROS";
    homepage = http://wiki.ros.org/rosunit;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
