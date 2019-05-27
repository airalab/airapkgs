{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, roscpp
, std_msgs
}:

let
  pname = "key_teleop";
  version = "0.3.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0fs55hcpn6sr0jkjhz4lpx4jyzl52zmwzzcx4sg8rrh3yyp0l1py";
  };

  propagatedBuildInputs =
  [ catkin message_generation roscpp std_msgs ];

  meta = with stdenv.lib; {
    description = "A text-based interface to send a robot movement commands.";
    homepage = http://wiki.ros.org/key_teleop;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
