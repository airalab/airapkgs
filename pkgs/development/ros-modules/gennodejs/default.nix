{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "gennodejs";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "RethinkRobotics-opensource";
    repo = "gennodejs";
    rev = "2.0.1";
    sha256 = "0swwgmdjixvfv67jqvia8aid727pnmc3v3wbpvsn2j5hv28vvpkk";
  };

  propagatedBuildInputs = with pkgs; [ catkin genmsg ];

  patchPhase = ''
    sed -i '1 i#!/usr/bin/env python' scripts/gen_nodejs.py
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/gennodejs-extras.cmake.em
  '';
}
