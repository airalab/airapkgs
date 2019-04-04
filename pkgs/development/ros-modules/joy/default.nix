{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, diagnostic_updater
, sensor_msgs
, roscpp
}:

let
  pname = "joy";
  version = "1.12.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "joystick_drivers-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1f6k2l0a025ysddsq2314s75mb4wd57dlmknjdqaxs1rqcqnxhcp";
  };

  propagatedBuildInputs = [ catkin diagnostic_updater sensor_msgs roscpp ];

  meta = with stdenv.lib; {
    description = "Standard controllers drivers";
    homepage = https://wiki.ros.org/joystick_drivers;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
