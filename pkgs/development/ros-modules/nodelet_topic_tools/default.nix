{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, dynamic_reconfigure
, boost167
}:

let
  pname = "nodelet_topic_tools";
  version = "1.9.16";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "nodelet_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0ma1k2q0k3p20l30dfhp6yijm22ygy04s4i2nizssc1a9byfaijx";
  };

  propagatedBuildInputs = [ catkin dynamic_reconfigure boost167 ];

  meta = with stdenv.lib; {
    description = "ROS node-like entities that run within the same process so as to avoid IPC and serialization overhead";
    homepage = https://wiki.ros.org/nodelet;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
