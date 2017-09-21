{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosgraph";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosgraph/1.13.2-0";
    sha256 = "1z94jdvily682lmqkhigh549nl66n8kdn3sv9b1f5fgw5b27kvp9";
  };

  propagatedBuildInputs = with pkgs; [ catkin pythonPackages.netifaces ];
}
