{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosbash";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/rosbash/1.14.1-0";
    sha256 = "16rpma98ggck93cx73w6kgchd5zq59dgy81601f5dznf77ksipx4";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];

  patchPhase = ''
    sed -i 's|_perm="+111"|_perm="/111"|' ./scripts/rosrun
  '';
}
