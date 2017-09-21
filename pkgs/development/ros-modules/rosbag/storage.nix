{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosbag_storage";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosbag_storage/1.13.2-0";
    sha256 = "116zpixmjc6rs33k76byksa53japflz7kpxc0bk7ldrrvcbdz6d8";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin cpp_common console-bridge roscpp_serialization
    roscpp_traits roslz4 bzip2 rostime];
}
