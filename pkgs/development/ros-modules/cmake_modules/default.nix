{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "cmake_modules";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "cmake_modules-release";
    rev = "release/lunar/cmake_modules/0.4.1-0";
    sha256 = "1z85gmadn5llnzabkkij2l5xf39mxc48v8i4m08vnpnljzr06x0i";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];
}
