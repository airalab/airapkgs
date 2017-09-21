{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roscpp";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/roscpp/1.13.2-0";
    sha256 = "0iphsh8wl74wqa50bqgy2s8g5x1hnxnlahk40mskizf9sdyrrxsz";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin cpp_common message_generation message_runtime
    rosconsole roscpp_serialization roscpp_traits rosgraph_msgs
    roslang rostime std_msgs xmlrpcpp ];
}
