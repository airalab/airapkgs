{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "genpy";
  version = "0.6.6";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "genpy-release";
    rev = "release/lunar/genpy/0.6.6-0";
    sha256 = "1rhmni7l1iwdkkb3wp3l3c8rrhrq27zj39zlkmdrd1f7isis3ijb";
  };

  propagatedBuildInputs = with pkgs; [ catkin genmsg pythonPackages.pyyaml ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/genpy-extras.cmake.em
  '';
}
