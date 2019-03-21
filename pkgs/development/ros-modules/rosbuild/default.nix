{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
}:

let
  pname = "rosbuild";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "08nffz4x7ax7594kbb23b88f478viq6zhz3ajjx8zgvrxfklx902";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime ];

  meta = with stdenv.lib; {
    description = "Contains scripts for managing the CMake-based build system for ROS";
    homepage = http://wiki.ros.org/rosbuild;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
