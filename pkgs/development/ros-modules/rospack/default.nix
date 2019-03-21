{ stdenv
, mkRosPackage
, fetchFromGitHub
, cmake_modules
, boost
, tinyxml-2
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "rospack";
  version = "2.5.3";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "rospack-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "17q0sls23yrlmlahscr83w3ingy3wfvivdxq8hfw09i9x3kvc2xc";
  };

  buildInputs = [ boost tinyxml-2 ];
  propagatedBuildInputs = [ cmake_modules ];

  meta = with stdenv.lib; {
    description = "ROS Package Tool";
    homepage = http://wiki.ros.org/rospack;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
