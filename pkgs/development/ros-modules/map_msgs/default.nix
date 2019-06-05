{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
, nav_msgs
, sensor_msgs
, std_msgs
}:

let
  pname = "map_msgs";
  version = "1.13.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "navigation_msgs-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "115vffj9shhidpzjwww9yml7n6jmjw07b6243qr01mkfnfba9k6c";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime nav_msgs sensor_msgs std_msgs ];

  meta = with stdenv.lib; {
    description = "Messages commonly used in mapping packages.";
    homepage = http://wiki.ros.org/map_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
