{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, rostime
, roscpp_traits
}:

let
  pname = "roscpp_serialization";
  version = "0.6.12";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0cid1kh7nd7k5n6r2crwx5nrcf45vmb03vd579hwf8l2agkbvb4k";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime roscpp_traits ];

  meta = with stdenv.lib; {
    description = "Contains the code for serialization, is a component of roscpp";
    homepage = http://wiki.ros.org/roscpp_serialization;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
