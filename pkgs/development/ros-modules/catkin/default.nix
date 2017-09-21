{ stdenv, pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "catkin";
  version = "0.7.7";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "catkin-release";
    rev = "release/lunar/catkin/0.7.7-2";
    sha256 = "03s81gmz0pzc03vsis0k88lc196mmghs04294ddwic0b9qhhrxd1";
  };
  
  propagatedBuildInputs = with pkgs; with pkgs.pythonPackages;
  [ cmake pkgconfig gtest
    python27 empy nose catkin_pkg rospkg ];

    #    sed -i 's|#!@PYTHON_EXECUTABLE@|#!${pyEnv.python.passthru.interpreter}|' ./cmake/templates/_setup_util.py.in
  patchPhase = ''
    sed -i 's/PYTHON_EXECUTABLE/SHELL/' ./cmake/catkin_package_xml.cmake
    sed -i 's|#!/usr/bin/env bash|#!${stdenv.shell}|' ./cmake/templates/setup.bash.in
    sed -i 's|#!/usr/bin/env sh|#!${stdenv.shell}|' ./cmake/templates/setup.sh.in
  '';
}
