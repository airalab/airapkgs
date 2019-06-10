{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, boost167
, message_generation
, roscpp
, std_msgs
}:

let
  pname = "dynamic_reconfigure";
  version = "1.6.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "dynamic_reconfigure-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "08kqkz1p3dzhif3ymy1rifss3zgzz0wjh9hq3rjydrj0mzm7dhpm";
  };

  propagatedBuildInputs = [ catkin boost167 message_generation roscpp std_msgs ];

  meta = with stdenv.lib; {
    description = "Provides a means to change node parameters at any time without having to restart the node.";
    homepage = https://wiki.ros.org/dynamic_reconfigure;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
