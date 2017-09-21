{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosmaster";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosmaster/1.13.2-0";
    sha256 = "0a5vb4bngh9nw2sb3qi5q5hw1633qf88p0dmyzq3q4gqfb3f7mzw";
  };

  propagatedBuildInputs = with pkgs; [ catkin rosgraph ];
}
