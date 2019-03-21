{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "roslang";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1n6775x93p87hjzdlq43h2h9fk7blcabyqca4gwrag0yxcmf52cj";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Common package that all ROS client libraries depend on";
    homepage = http://wiki.ros.org/roslang;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
