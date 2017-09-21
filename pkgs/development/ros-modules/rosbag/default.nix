{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosbag";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosbag/1.13.2-0";
    sha256 = "1s971nqypg12mjb5ay0aq4vggzcs4w4mvy7hk229609mwjn14k71";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin cpp_common genmsg genpy rosbag_storage rosconsole std_srvs
    roscpp roscpp_serialization roslib rospy topic_tools xmlrpcpp ];
}
