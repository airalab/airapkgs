{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, angles
, roscpp
, sensor_msgs
, tf
, tf2
}:

let
  pname = "laser_geometry";
  version = "1.6.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1jcmp2f2dm7masl8m8lxy29lh7631zlrkl02iwwqlc1snkrgvh94";
  };

  propagatedBuildInputs = [ catkin angles roscpp sensor_msgs tf tf2];

  meta = with stdenv.lib; {
    description = "Class for converting from a 2D laser scan as defined by sensor_msgs/LaserScan into a point cloud as defined by sensor_msgs/PointCloud or sensor_msgs/PointCloud2.";
    homepage = http://wiki.ros.org/laser_geometry;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
