{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, boost167
, cmake_modules
, roscpp
, bond
, smclib
# , unique_id
# , uuid_msgs
, libuuid
}:

let
  pname = "bondcpp";
  version = "1.8.3";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "bond_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1mw4a32726s92ms4gv41cz1dxkr9jddj8yp5w0s4pl9z4z6sdmsk";
  };

  propagatedBuildInputs = [ catkin boost167 cmake_modules roscpp bond smclib libuuid ];

  meta = with stdenv.lib; {
    description = "C++ implementation of bond, a mechanism for checking when another process has terminated.";
    homepage = https://wiki.ros.org/bondcpp;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
