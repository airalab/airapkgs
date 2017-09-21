{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosout";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosout/1.13.2-0";
    sha256 = "1262lv58rk2bnvr7rkszgy3f5shgbzz7mfbv0h69pm90primhqn3";
  };

  propagatedBuildInputs = with pkgs; [ catkin roscpp rosgraph_msgs ];
}
