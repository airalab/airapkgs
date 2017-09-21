{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosservice";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosservice/1.13.2-0";
    sha256 = "1aqkwvx5fyxjx9915x92nm954fmq6lfqixq7ssvxl3l8p6ifwjml";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin genpy rosgraph roslib rosmsg rospy ];
}
