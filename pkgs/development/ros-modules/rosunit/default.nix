{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosunit";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/rosunit/1.14.1-0";
    sha256 = "1iaj6fx1fdfwvl35ng9dz87jp75fk28vrmmqjq2ky53k5jdhl8ka";
  };

  propagatedBuildInputs = with pkgs; [ catkin roslib ];
}
