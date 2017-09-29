{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosnode";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosnode/1.13.2-0";
    sha256 = "11bj68g7hxjg5fw8bjpyyxk49p3frfk9qb6658nqkxnwpz78jbdz";
  };

  propagatedBuildInputs = with pkgs; [ catkin rosgraph rostopic ];
}
