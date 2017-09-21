{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosparam";
  version = "1.13.2";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/rosparam/1.13.2-0";
    sha256 = "0v3hfc4babgxkif69f5wz9jmd7i3cjv1ml8bq766k484dbhg20pc";
  };

  propagatedBuildInputs = with pkgs; [ catkin rosgraph ];
}
