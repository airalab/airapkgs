{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roscpp";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosconsole/1.13.2-0";
    sha256 = "1faipbajmpr441i80p49vkg4h73k1m4098pc8gx0fll02gdhw266";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin boost cpp_common log4cxx rosbuild rostime rosunit ];
}
