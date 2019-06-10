{ stdenv
, mkRosPackage
, fetchFromGitHub
, eigen3_3
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "cmake_modules";
  version = "0.4.2";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "11kh2z059ffxgjzrzh9jgdln3fhydh799bc590kfgxcqjx0kqpli";
  };

propagatedBuildInputs = [ eigen3_3 ];

  meta = with stdenv.lib; {
    description = "A common repository for CMake Modules for ROS";
    homepage = http://wiki.ros.org/cmake_modules;
    license = licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.akru ];
  };
}
