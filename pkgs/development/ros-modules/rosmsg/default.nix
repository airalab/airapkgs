{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosmsg";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosmsg/1.13.2-0";
    sha256 = "1zgih1mpwrgx5pmh04xb8yjsfc1z1gvs9xmkahn7ai512061vmk7";
  };

  propagatedBuildInputs = with pkgs; [ catkin genmsg rosbag roslib ];
}
