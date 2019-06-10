{ stdenv
, mkRosPackage
, fetchFromGitHub
, eigen3_3
, boost
, pcl
, cmake_modules
, pcl_msgs
, dynamic_reconfigure
, message_filters
, nodelet
, nodelet_topic_tools
}:

let
  pname = "pcl_conversions";
  version = "1.6.2";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "perception_pcl-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0wl79qlj1j2a79w3ppvxwb4ifigmrycq82zrzrdzkajcjb4i568z";
  };

  postPatch = ''
    sed -i '/find_package(Eigen3 REQUIRED)/d' CMakeLists.txt
  '';

  buildInputs = [ eigen3_3 boost pcl ];
  propagatedBuildInputs = [ cmake_modules pcl_msgs dynamic_reconfigure message_filters nodelet nodelet_topic_tools ];

  meta = with stdenv.lib; {
    description = "PCL (Point Cloud Library) ROS interface stack.";
    homepage = https://wiki.ros.org/pcl_ros;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
