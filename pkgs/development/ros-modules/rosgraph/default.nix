{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, python3Packages
}:

let
  pname = "rosgraph";
  version = "1.14.4";
  rosdistro = "melodic";


in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1kq51pp02m2i7khy8vhi85wmrjcd88dckk0j4gynpbawk11yxnzm";
  };

  propagatedBuildInputs = [ catkin python3Packages.netifaces ];

  meta = with stdenv.lib; {
    description = "Command-line tool, which prints information about the ROS Computation Graph";
    homepage = http://wiki.ros.org/rosgraph;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
