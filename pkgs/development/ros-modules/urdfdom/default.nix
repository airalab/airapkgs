{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake
, urdfdom_headers
, console_bridge
, pkgconfig
, tinyxml
, boost
}:

let
  pname = "urdfdom";
  version = "0.3.0";
  rosdistro = "indigo";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "urdfdom-release";
    rev = "release/${rosdistro}/${pname}/${version}-1";
    sha256 = "1hrm9nl3w47ami201xg6mjlh21si6vsbrb1a11svvfdxjzn8aids";
  };

  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [ boost ];

  propagatedBuildInputs = [ catkin urdfdom_headers console_bridge tinyxml ];

  meta = with stdenv.lib; {
    description = "A temporary pass through to the urdfdom rosdep";
    homepage = http://wiki.ros.org/urdfdom;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
