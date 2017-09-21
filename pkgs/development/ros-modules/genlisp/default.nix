{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "genlisp";
  version = "0.4.16";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "genlisp-release";
    rev = "release/lunar/genlisp/0.4.16-0";
    sha256 = "0qndyl118h7y6amsydfaippb5lk1s2lbk38f4b88012522bgf1mf";
  };

  propagatedBuildInputs = with pkgs; [ catkin genmsg ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/genlisp-extras.cmake.em
  '';
}
