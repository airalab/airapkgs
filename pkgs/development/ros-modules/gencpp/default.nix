{ stdenv
, mkRosPackage
, fetchFromGitHub
, genmsg
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "gencpp";
  version = "0.6.2";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0vvbi2nkdalmq6h3kr2r9r3ragpxhrw5zdfxihrxd8g0jiqsa8s5";
  };

  propagatedBuildInputs = [ genmsg ];

  patchPhase = ''
    sed -i 's/''${PYTHON_EXECUTABLE} //' ./cmake/gencpp-extras.cmake.em
  '';

  meta = with stdenv.lib; {
    description = "C++ ROS message and service generators";
    homepage = http://wiki.ros.org/gencpp;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
