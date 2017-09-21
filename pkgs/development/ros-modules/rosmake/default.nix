{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosmake";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/rosmake/1.14.1-0";
    sha256 = "0fr1a2r2j5gz2l9nfy9ajnn70gw9mmrl14k6ch9kn554iskyj99a";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];
}
