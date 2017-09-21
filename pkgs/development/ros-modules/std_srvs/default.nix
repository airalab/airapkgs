{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "std_srvs";
  version = "1.11.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm_msgs-release";
    rev = "release/lunar/std_srvs/1.11.2-0";
    sha256 = "1lrc01bxlh4arcjaxa1vlzvhvcp5xd4ia0g01pbblmmhvyfy06s7";
  };

  propagatedBuildInputs = with pkgs; [ catkin message_generation message_runtime ];
}
