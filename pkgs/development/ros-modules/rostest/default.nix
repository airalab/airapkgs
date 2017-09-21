{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rostest";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rostest/1.13.2-0";
    sha256 = "1z07k0zwmnsz8p5gnxnrl5z5vlfwdzlsdr01yvb4c4pzdka5nq4h";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin rosgraph roslaunch rosmaster rospy rosunit ];
}
