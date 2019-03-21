{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosmake";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1abv7pi9cqjk5y9rss9y602yk2p49mvl46m5hsrpw8bjxm1ldrs7";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "ROS dependency aware build tool which can be used to build all dependencies in the correct order";
    homepage = http://wiki.ros.org/rosmake;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
