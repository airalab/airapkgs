{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, boost
, cpp_common
, log4cxx
, rosbuild
, rostime
, rosunit
}:

let
  pname = "rosconsole";
  version = "1.13.10";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "18vkbynzczw8bd25mix0ajw8f7ljrpyy15p1aw16gkx17w2yb6d3";
  };

  propagatedBuildInputs = [ catkin boost cpp_common log4cxx rosbuild rostime rosunit ];

  meta = with stdenv.lib; {
    description = "ROS console output library";
    homepage = http://wiki.ros.org/rosconsole;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
