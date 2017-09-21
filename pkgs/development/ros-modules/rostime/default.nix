{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rostime";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/lunar/rostime/0.6.5-0";
    sha256 = "1k10jqw75r5697pxriyr37sg6lhcg7yh6ia5f6ij95l6grsc8wcs";
  };

  propagatedBuildInputs = with pkgs; [ catkin cpp_common ];
}
