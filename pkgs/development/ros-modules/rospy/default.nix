{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rospy";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rospy/1.13.2-0";
    sha256 = "0rjx72a44yrga17gcz6bv65ip9r8vdaq2myi213pnra4zd6ksd32";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin genpy roscpp rosgraph rosgraph_msgs roslib std_msgs ];
}
