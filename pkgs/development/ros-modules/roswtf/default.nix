{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roswtf";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/roswtf/1.13.2-0";
    sha256 = "0413bdk29k3b6faqgjcssrya1ibagcwj5wyncchn41k9is4z1and";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin rosbuild rosgraph roslaunch roslib rosnode rosservice rostest ];
}
