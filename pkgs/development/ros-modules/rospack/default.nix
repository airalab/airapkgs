{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rospack";
  version = "2.4.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "rospack-release";
    rev = "release/lunar/rospack/2.4.2-0";
    sha256 = "013vv4h1bqk53av20d9dkbrdwiqapm0cafvpgdn1k1ra4jc5816d";
  };

  propagatedBuildInputs = with pkgs; [ catkin cmake_modules boost tinyxml-2 ];
}
