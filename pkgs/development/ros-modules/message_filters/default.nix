{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "message_filters";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/message_filters/1.13.2-0";
    sha256 = "0ccbc88zpm0y0s4sgnf1bf944g3xn482jfh3cyvl2m428g9gc0gh";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin rosconsole rostest roscpp rosunit xmlrpcpp ];
}
