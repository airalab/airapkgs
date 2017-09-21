{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "genmsg";
  version = "0.5.9";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "genmsg-release";
    rev = "release/lunar/genmsg/0.5.9-0";
    sha256 = "0db60bw64fxbqym10f63r387q5wk6i35sd1vyragi3xp3fzi74yd";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} ''${GENMSG_CHECK_DEPS_SCRIPT}/''${GENMSG_CHECK_DEPS_SCRIPT}/' ./cmake/pkg-genmsg.cmake.em
  '';
}
