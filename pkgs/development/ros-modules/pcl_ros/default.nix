{ stdenv
, mkRosPackage
, fetchFromGitHub
, eigen3_3
, boost
, pcl
, pcl_msgs
, pcl_conversions
, cmake_modules
, dynamic_reconfigure
, message_filters
, nodelet
, nodelet_topic_tools
, rosbag
, tf
, tf2_eigen
}:

let
  pname = "pcl_ros";
  version = "1.6.2";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "perception_pcl-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0pas46yick9jbq4mf9an5x6cd5bch711byfxm3pl22xkz3j2m598";
  };

  postPatch = ''
    sed -i '/find_package(Eigen3 REQUIRED)/d' CMakeLists.txt;
  '';

  buildInputs = [ eigen3_3 boost pcl ];
  propagatedBuildInputs = [ cmake_modules pcl_conversions pcl_msgs pcl dynamic_reconfigure message_filters nodelet nodelet_topic_tools rosbag tf tf2_eigen ];

  meta = with stdenv.lib; {
    description = "PCL (Point Cloud Library) ROS interface stack.";
    homepage = https://wiki.ros.org/pcl_ros;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
