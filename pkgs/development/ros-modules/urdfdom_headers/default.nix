{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake
, urdfdom
}:

let
  pname = "urdfdom_headers";
  version = "0.3.0";
  rosdistro = "indigo";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "urdfdom_headers-release";
    rev = "release/${rosdistro}/${pname}/${version}-2";
    sha256 = "10d8c0149850xrgpkvwflbkdsq5hzibh128kka4awihn6cf49hrp";
  };

propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Temporary package redirecting to C++ Headers for URDF";
    homepage = http://wiki.ros.org/urdfdom_headers;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
