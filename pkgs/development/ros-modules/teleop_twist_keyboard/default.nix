{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, roscpp
, std_msgs
}:

let
  pname = "teleop_twist_keyboard";
  version = "0.6.2";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1h2pf44qxnk1i7a8lps8p5748a6k2wv65rrdi0cn1nckimlizc58";
  };

  propagatedBuildInputs =
  [ catkin message_generation roscpp std_msgs ];

  meta = with stdenv.lib; {
    description = "Generic Keyboard Teleop for ROS";
    homepage = http://wiki.ros.org/teleop_twist_keyboard;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
