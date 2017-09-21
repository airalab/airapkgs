{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roscpp_serialization";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/roscpp_serialization/0.6.5-0";
    sha256 = "1a70l7ywa2xx9ms9nh96r1icpysy6yp9hm4bm0fvfkpbazkzqjwk";
  };

  propagatedBuildInputs = with pkgs; [ catkin cpp_common rostime roscpp_traits ];
}
