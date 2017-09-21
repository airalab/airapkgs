{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "topic_tools";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/topic_tools/1.13.2-0";
    sha256 = "16py2gr7ci8ya08v13w290qcg2nn386idmj9jkzpshrr8w3m53h1";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin cpp_common message_generation message_runtime rosconsole
    roscpp rostest rostime rosunit std_msgs xmlrpcpp ];
}
