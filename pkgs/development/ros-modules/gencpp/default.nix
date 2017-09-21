{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "gencpp";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "gencpp-release";
    rev = "release/lunar/gencpp/0.5.5-0";
    sha256 = "1x3kf64yywc9d2s071i8hizgqkv38r2dpz1gs8qk916r8yizsa7f";
  };

  propagatedBuildInputs = with pkgs; [ catkin genmsg ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/gencpp-extras.cmake.em
  '';
}
