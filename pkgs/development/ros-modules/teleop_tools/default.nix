{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, roscpp
, std_msgs
}:

let
  pname = "teleop_tools";
  version = "0.3.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1gcwzy7wsaq31pycx9i20gr9z6wnxcq1gfk6bmzkf369ann64hic";
  };

  propagatedBuildInputs =
  [ catkin message_generation roscpp std_msgs ];

  meta = with stdenv.lib; {
    description = "A set of generic teleoperation tools for any robot.";
    homepage = http://wiki.ros.org/teleop_tools;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
