{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "geneus";
  version = "2.2.6";

  src = fetchFromGitHub {
    owner = "jsk-ros-pkg";
    repo = "geneus";
    rev = "2.2.6";
    sha256 = "0i0j9g6qq52n9d3fk0vcdzvyndci5jmqs09zhdvk8wx9p8p5c37h";
  };

  propagatedBuildInputs = with pkgs; [ catkin genmsg ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/geneus-extras.cmake.em
  '';
}
