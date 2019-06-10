{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
, geometry_msgs
, std_msgs
}:

let
  pname = "visualization_msgs";
  version = "1.12.7";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "common_msgs-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "13c8mmflnl6wgnpvvha6qb5x07v542imyg6cal4g3s29c95rjilq";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime geometry_msgs ];

  meta = with stdenv.lib; {
    description = "Set of messages used by higher level packages, such as rviz, that deal in visualization-specific data.";
    homepage = http://wiki.ros.org/visualization_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
