{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosclean";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/rosclean/1.14.1-0";
    sha256 = "1pv3wfdmjbyrchyznnh1qxhybm9l14hwacqzz8gigc584wa76ivz";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];
}
