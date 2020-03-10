{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, genpy
, roscpp
, rosgraph
, rosgraph_msgs
, roslib
, std_msgs
}:

let
  pname = "rospy";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0k99wckkvigq98rs2gx96s89g2a05d9p7yxhhzfxfhx8gkz4jabj";
  };

  propagatedBuildInputs = [ catkin genpy roscpp rosgraph rosgraph_msgs roslib std_msgs ];

  meta = with stdenv.lib; {
    description = "Python client library for ROS";
    homepage = http://wiki.ros.org/rospy;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
