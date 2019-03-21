{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosbash
, rosboost_cfg
, rosbuild
, rosclean
, roscreate
, roslang
, roslib
, rosmake
, rosunit
}:

let
  pname = "ros";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0kwa2alz4hxp20qclfpcwr2wahd76la06k3xh5k0062r6pp7d64w";
  };

  propagatedBuildInputs = [ catkin rosbash rosboost_cfg rosbuild rosclean
                            roscreate roslang roslib rosmake rosunit ];

  meta = with stdenv.lib; {
    description = "ROS packaging system";
    homepage = http://wiki.ros.org/ros;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
