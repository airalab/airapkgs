{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roscpp_traits";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/roscpp_traits/0.6.5-0";
    sha256 = "0z5gazbp3bd2m6jzhabn3b9wy9cvw69hlslj5yxplkhhbp2qrgpd";
  };

  propagatedBuildInputs = with pkgs; [ catkin cpp_common rostime ];
}
