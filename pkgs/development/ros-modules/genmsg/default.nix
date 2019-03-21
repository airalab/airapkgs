{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "genmsg";
  version = "0.5.12";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1jlkf6nk86ywppjk9241l7a2li14mwmx62pq8651x1yrskbpz818";
  };

  propagatedBuildInputs = [ catkin ];

  postPatch = ''
    sed -i 's/''${PYTHON_EXECUTABLE} ''${GENMSG_CHECK_DEPS_SCRIPT}/''${GENMSG_CHECK_DEPS_SCRIPT}/' ./cmake/pkg-genmsg.cmake.em
  '';

  meta = with stdenv.lib; {
    description = "Standalone Python library for generating ROS message and service data structures for various languages";
    homepage = http://wiki.ros.org/genmsg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
