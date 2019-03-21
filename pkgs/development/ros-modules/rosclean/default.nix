{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosclean";
  version = "1.14.6";
  rosdistro = "melodic";
  
in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1xpmca1a66dwznja4syc639akhmnnjj1g7hzmshqi61vw0yws9gw";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Cleanup filesystem resources (e.g. log files)";
    homepage = http://wiki.ros.org/rosclean;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
