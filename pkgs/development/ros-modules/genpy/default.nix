{ stdenv
, mkRosPackage
, fetchFromGitHub
, genmsg
, python3Packages
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "genpy";
  version = "0.6.8";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0mcka9l02bblrxddybm3msn8rzxi4pb6fx3vi7jy19dzcqgnkg05";
  };

  propagatedBuildInputs = with python3Packages; [ genmsg pyyaml ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/genpy-extras.cmake.em
  '';

  meta = with stdenv.lib; {
    description = "Python ROS message and service generators";
    homepage = http://wiki.ros.org/genpy;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
