{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosgraph_msgs";
  version = "1.11.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm_msgs-release";
    rev = "release/lunar/rosgraph_msgs/1.11.2-0";
    sha256 = "1acyvalskr9hk23g2rsavpanjvnhq1cz467lnymyh4xd5g7xkrza";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin message_generation message_runtime std_msgs ];
}
