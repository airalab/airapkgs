{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "rosbuild";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/rosbuild/1.14.1-0";
    sha256 = "0npnkkfyr5nrxr1g9kak1i2cjc6vmz87v1p89901yawcl1g8hkix";
  };

  propagatedBuildInputs = with pkgs; [ catkin message_generation message_runtime ];
}
