{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "cpp_common";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/cpp_common/0.6.5-0";
    sha256 = "0jrlk3w8hqi76gc216d0ll394kmrr2nl1n85c7hsfivfpizxl5xv";
  };

  propagatedBuildInputs = with pkgs; [ catkin boost console-bridge ];
}
