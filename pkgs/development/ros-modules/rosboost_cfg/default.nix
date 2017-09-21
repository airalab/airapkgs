{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosboost_cfg";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/rosboost_cfg/1.14.1-0";
    sha256 = "051psvfx6qw9swia21azk45cwzm9wvpnfjyfh3sy7b6ri0h8zyhj";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];
}
