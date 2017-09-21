{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "std_msgs";
  version = "0.5.11";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "std_msgs-release";
    rev = "release/lunar/std_msgs/0.5.11-0";
    sha256 = "0wb2c2m0c7ysfwmyanrkx7n1iy0xr7fawjp2vf6xmk5469jz2l9b";
  };

  propagatedBuildInputs = with pkgs; [ catkin message_generation message_runtime ];
}
