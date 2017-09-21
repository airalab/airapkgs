{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roslang";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/roslang/1.14.1-0";
    sha256 = "04hj3qv0gyc9ld0pyxjmw54y6jxag5x5dg864zc1jah09mz3sxvh";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];
}
