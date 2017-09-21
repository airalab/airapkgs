{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roslz4";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/roslz4/1.13.2-0";
    sha256 = "1xm1y28kb22lvsijazybha1khcxvhvf2gznm1cr2dnc2rgvfdd41";
  };

  propagatedBuildInputs = with pkgs; [ catkin lz4 ];
}
