{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rostopic";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rostopic/1.13.2-0";
    sha256 = "01jdj7fl8pi6chhx3rliiv91ff76qqj16i2r4fcz0p7n3b887jk1";
  };

  propagatedBuildInputs = with pkgs; [ catkin genpy rosbag rospy rostest ];
}
