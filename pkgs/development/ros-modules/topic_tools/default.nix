{ stdenv
, mkRosPackage
, fetchFromGitHub
, cpp_common
, message_generation
, message_runtime
, rosconsole
, roscpp
, rostest
, rostime
, rosunit
, std_msgs
, xmlrpcpp
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "topic_tools";
  version = "1.14.4";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "139aj7g99s9bisd6sqakfymmkaf7nyx8k9hh8bsjc1ayn3127i00";
  };

  propagatedBuildInputs =
  [ cpp_common message_generation message_runtime rosconsole
    roscpp rostest rostime rosunit std_msgs xmlrpcpp ];

  meta = with stdenv.lib; {
    description = "Tools for directing, throttling, selecting, and otherwise messing with ROS topics";
    homepage = http://wiki.ros.org/topic_tools;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
