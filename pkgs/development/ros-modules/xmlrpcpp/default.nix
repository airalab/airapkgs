{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roscpp";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/xmlrpcpp/1.13.2-0";
    sha256 = "04zzzpkgp6s1628rnzxncp0z7pf0d4drj5ark7sx3bz5qnmsiwgh";
  };

  propagatedBuildInputs = with pkgs; [ catkin cpp_common ];
}
