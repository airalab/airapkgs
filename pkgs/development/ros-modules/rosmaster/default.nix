{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosgraph
}:

let
  pname = "rosmaster";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0cw2yvh8cj2rha6y7rv0gc77rjwlp4z2q5bv6b7ggnz88i0gxkd2";
  };

  propagatedBuildInputs = [ catkin rosgraph ];

  meta = with stdenv.lib; {
    description = "ROS Master implementation";
    homepage = http://wiki.ros.org/rosmaster;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
