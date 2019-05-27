{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, geometry_msgs
, message_generation
, message_runtime
, std_msgs
}:

let
  pname = "trajectory_msgs";
  version = "1.12.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "common_msgs-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0w7sl5yqkggf37ji566a4ayhfb2y8kgjc14gc6dm06f1zwd9g88m";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime std_msgs geometry_msgs ];

  meta = with stdenv.lib; {
    description = "Messages for defining robot trajectories.";
    homepage = http://wiki.ros.org/trajectory_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
