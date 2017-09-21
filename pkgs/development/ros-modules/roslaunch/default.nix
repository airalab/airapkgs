{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roslaunch";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/roslaunch/1.13.2-0";
    sha256 = "1v2aqdgjbgq05z8aszazhzy9a6jvzvjgdn10mqhmji16h40alqhx";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin rosclean rosgraph_msgs roslib
    rosmaster rosout rosparam rosunit
    pythonPackages.defusedxml ];
}
