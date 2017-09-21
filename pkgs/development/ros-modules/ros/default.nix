{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "ros";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/ros/1.14.1-0";
    sha256 = "0rjpfmdcqnpxy0w2iyacn547ix7h4fh4h8jcvxm0hx58zfvfpzqk";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin rosbash rosboost_cfg rosbuild rosclean
    roscreate roslang roslib rosmake rosunit ];
}
