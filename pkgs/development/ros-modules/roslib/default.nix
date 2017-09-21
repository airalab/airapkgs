{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roslib";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/roslib/1.14.1-0";
    sha256 = "1qnwclzym3shvf68vls6nxaxsdkh0cl3c5q20446c4j5shfj3gx6";
  };

  propagatedBuildInputs = with pkgs; [ catkin rospack ];
}
