{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
, sensor_msgs
, std_msgs
}:

let
  pname = "pcl_msgs";
  version = "0.2.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "pcl_msgs-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "15m9kp7agg9402qxxxns1pk63pr75jq6zib2dqb17y7fi4grch9a";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime sensor_msgs std_msgs ];

  meta = with stdenv.lib; {
    description = "PCL (Point Cloud Library) ROS interface stack.";
    homepage = https://wiki.ros.org/pcl_ros;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
