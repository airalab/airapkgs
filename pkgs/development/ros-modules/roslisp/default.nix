{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roslisp";
  version = "1.9.21";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roslisp-release";
    rev = "release/lunar/roslisp/1.9.21-0";
    sha256 = "16pr64a4ydizz57v3b779fblczb1r4xyxfir1yyvks9kkyf3s6mm";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin rosgraph_msgs roslang rospack std_msgs sbcl ];
}
