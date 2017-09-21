{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "ros_comm";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/ros_comm/1.13.2-0";
    sha256 = "03660xd4h30pgy896mgdcdgsh9hfrlmfvffwrjjck2gwpyfl1qdv";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin message_filters ros rosbag rosconsole roscpp
    rosgraph rosgraph_msgs roslaunch roslisp rosmaster
    rosmsg rosnode rosout rosparam rospy rosservice
    rostest rostopic roswtf std_srvs topic_tools xmlrpcpp ];
}
