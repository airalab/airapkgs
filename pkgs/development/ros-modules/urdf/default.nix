{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake_modules
, pluginlib
, rosconsole_bridge
, roscpp
, urdf_parser_plugin
, urdfdom_headers
, urdfdom
, tinyxml-2
}:

let
  pname = "urdf";
  version = "1.13.1";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "urdf-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "10d8c0149850xrgpkvwflbkdsq5hzibh128kka4awihn6cf49hrp";
  };

  propagatedBuildInputs = [ catkin cmake_modules pluginlib rosconsole_bridge roscpp urdf_parser_plugin urdfdom_headers urdfdom tinyxml-2 ];

  meta = with stdenv.lib; {
    description = "Parser for the Unified Robot Description Format (URDF).";
    homepage = http://wiki.ros.org/urdf;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
