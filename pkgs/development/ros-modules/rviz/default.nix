{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake_modules
, geometry_msgs
, image_transport
, interactive_markers
, laser_geometry
, map_msgs
, media_export
, message_filters
, nav_msgs
, pluginlib
, python_qt_binding
, resource_retriever
, rosbag
, rosconsole
, roscpp
, roslib
, rospy
, sensor_msgs
, std_msgs
, std_srvs
, tf
, urdf
, visualization_msgs
}:

let
  pname = "rviz";
  version = "1.13.3";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "rviz-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1cdyylippwirr2ga62zqgyxym95hy66x0mlbqwncl5w9pw3b7ymm";
  };

  propagatedBuildInputs = [ catkin cmake_modules geometry_msgs image_transport interactive_markers laser_geometry map_msgs media_export message_filters nav_msgs pluginlib python_qt_binding resource_retriever rosbag rosconsole roscpp roslib rospy sensor_msgs std_msgs std_srvs tf urdf visualization_msgs ];

  meta = with stdenv.lib; {
    description = "3D visualization tool for ROS.";
    homepage = http://wiki.ros.org/rviz;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe  ];
  };
}
