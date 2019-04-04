{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake_modules
, message_generation
, pluginlib
, rosconsole
, roscpp
, std_msgs
, bondcpp
, boost167
, libuuid
}:

let
  pname = "nodelet";
  version = "1.9.16";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "nodelet_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0djnk2k0x8z9xcmrq4b46j08q6ddwl62nxn6r6qchy5har10cb27";
  };

  propagatedBuildInputs = [ catkin cmake_modules message_generation pluginlib rosconsole roscpp std_msgs bondcpp  boost167 libuuid ];

  meta = with stdenv.lib; {
    description = "ROS node-like entities that run within the same process so as to avoid IPC and serialization overhead";
    homepage = https://wiki.ros.org/nodelet;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
